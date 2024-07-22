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

resource "azurerm_resource_group" "demo-rg" {
  name     = "demo-rg"
  location = "eastus"
  tags = {
    terraform = "True"
  }
}

resource "azurerm_virtual_network" "demoVnet" {
  resource_group_name = azurerm_resource_group.demo-rg.name
  name                = "demoVnet"
  location            = azurerm_resource_group.demo-rg.location
  address_space       = ["10.0.0.0/16"]
  tags = {
    terraform = "True"
  }
}

resource "azurerm_subnet" "variable-subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.demo-rg.name
  virtual_network_name = azurerm_virtual_network.demoVnet.name
  address_prefixes     = [var.address_prefixes]
}

output "subnet-details" {
  value =[azurerm_subnet.variable-subnet.name, azurerm_subnet.variable-subnet.address_prefixes] 
}