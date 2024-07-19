# Here we will explore the azure terraform provider

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mynewrg" {
  location = "eastus"
  name     = "mynewrg"
  tags = {
    terraform = "True"
  }

}

resource "azurerm_virtual_network" "newVnet" {
  name                = "newVnet"
  resource_group_name = azurerm_resource_group.mynewrg.name
  location            = azurerm_resource_group.mynewrg.location
  address_space       = ["10.0.0.0/16"]

  tags = {
    terraform = "True"
  }

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
  }
  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
  }
}

resource "azurerm_virtual_machine" "VM1-tf" {
  resource_group_name = azurerm_resource_group.mynewrg.name
  location            = azurerm_resource_group.mynewrg.location
  name                = "VM1-tf"
  network_interface_ids = [
    azurerm_network_interface.nic1-tf.id
  ]
  vm_size = "Standard_DS1_v2"
}

output "resource_group" {
  value       = azurerm_resource_group.mynewrg
  description = "Resource group created by terraform"
}

output "subnets" {
  value       = azurerm_virtual_network.newVnet.subnet
  description = "IP range of subnets"
}

