# Short description of the use case in comments

locals {
  name          = "test-example"
  address_space = ["10.0.0.0/8"]
}

module "virtual_network" {
  source = "git@github.com:padok-team/terraform-azurerm-virtual-network.git?ref=v0.0.1"

  name                = "vnet-${local.name}"
  resource_group_name = module.resource_group.this.name
  location            = module.resource_group.this.location
  address_space       = local.address_space

}

module "resource_group" {
  source   = "git@github.com:padok-team/terraform-azurerm-resource-group.git?ref=v0.0.2"
  name     = "example-resources"
  location = "West Europe"
}

module "azurerm_subnet" {
  source = "git@github.com:padok-team/terraform-azurerm-subnet.git?ref=v0.0.1"

  name             = "subnet-${local.name}"
  address_prefixes = ["10.0.0.0/24"]

  resource_group_name  = module.resource_group.this.name
  virtual_network_name = module.virtual_network.this.name
}
