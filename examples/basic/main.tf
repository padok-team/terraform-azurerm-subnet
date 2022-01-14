# This exemple creates a virtual network and a subnet in this virtual network.

terraform {
  required_version = ">= 0.13.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.82.0"
    }
  }
}

provider "azurerm" {
  features {}
}

locals {
  name          = "test-example"
  address_space = ["10.0.0.0/8"]
}

module "virtual_network" {
  source = "git@github.com:padok-team/terraform-azurerm-virtual-network.git?ref=v1.0.0"

  name                = "vnet-${local.name}"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  address_space       = local.address_space

}

resource "azurerm_resource_group" "example" {
  name     = "example-resources"
  location = "West Europe"
}

module "azurerm_subnet" {
  source = "./../.."

  name             = "subnet-${local.name}"
  address_prefixes = ["10.0.0.0/24"]

  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_resource_group.example.name
}
