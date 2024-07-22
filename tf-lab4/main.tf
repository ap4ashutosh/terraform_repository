# Here we will explore the azure terraform provider

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
}
provider "random" {
  
}
# Taking the azure provider
provider "azurerm" {
  features {}
}

resource "random_string" "name" {
  length = 6
  upper = false
  lower = true
  special = false
}

# Creating the resource group
resource "azurerm_resource_group" "mynewrg" {
  location = "eastus"
  name     = "mynewrg"
  tags = {
    terraform = "True"
  }

}

# Creating a virtual network
resource "azurerm_virtual_network" "newVnet" {
  name                = "newVnet"
  resource_group_name = azurerm_resource_group.mynewrg.name
  location            = azurerm_resource_group.mynewrg.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    terraform = "True"
  }
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.mynewrg.name
  virtual_network_name = azurerm_virtual_network.newVnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.mynewrg.name
  virtual_network_name = azurerm_virtual_network.newVnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Configuring a network interface
resource "azurerm_network_interface" "newNIC" {
  name                = "newNIC"
  resource_group_name = azurerm_resource_group.mynewrg.name
  location            = azurerm_resource_group.mynewrg.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Static" 
  }
}

resource "azurerm_public_ip" "VmIP" {
  resource_group_name = azurerm_resource_group.mynewrg.name
  name                = "VmIP"
  location            = azurerm_resource_group.mynewrg.location
  allocation_method   = "Dynamic"
  tags = {
    terraform = "True"
  }
}

# Configuring a VM
resource "azurerm_linux_virtual_machine" "newlinuxVM" {
  name                = "newlinuxVM"
  resource_group_name = azurerm_resource_group.mynewrg.name
  location            = azurerm_resource_group.mynewrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.newNIC.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  # os_profile{
  #   admin_username = "admin"
  #   admin_password = "Password1234!"

  # }
  admin_password = "Password1234!"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    terraform = "True"
  }
}

resource "azurerm_storage_account" "new-storage"{
  name = "azuretfstorage${random_string.name.result}"
  resource_group_name = azurerm_resource_group.mynewrg.name
  location = azurerm_resource_group.mynewrg.location
  account_tier = "Standard"
  account_replication_type = "LRS"
  allow_nested_items_to_be_public = true
  tags = {
    terraform = "True"
  }
}

resource "azurerm_storage_container" "new-container" {
  storage_account_name = azurerm_storage_account.new-storage.name
  name                 = "tfstate"
  container_access_type = "private"
}

output "resource_group" {
  value       = azurerm_resource_group.mynewrg
  description = "Resource group created by terraform"
}

output "subnets" {
  value       = azurerm_virtual_network.newVnet.subnet
  description = "IP range of subnets"
}

output "aboutVM_IP" {
  value       = azurerm_linux_virtual_machine.newlinuxVM.public_ip_address
  description = "value of public IP"
}

output "VM_password" {
  value     = azurerm_linux_virtual_machine.newlinuxVM.admin_password
  sensitive = true
}

output "storage_account" {
  value = azurerm_storage_account.new-storage.access_tier
}

output "storage_account_name" {
  value = azurerm_storage_account.new-storage.name
}