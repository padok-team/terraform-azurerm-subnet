resource "azurerm_subnet" "this" {

  address_prefixes = var.address_prefixes

  dynamic "delegation" {
    for_each = var.delegation != null ? var.delegation : []
    content {
      name = delegation.value.name
      service_delegation {
        actions = delegation.value.service_delegation.actions
        name    = delegation.value.service_delegation.name
      }
    }
  }

  # One of them
  enforce_private_link_endpoint_network_policies = var.enforce_private_link_endpoint_network_policies != null ? var.enforce_private_link_endpoint_network_policies : null
  enforce_private_link_service_network_policies  = var.enforce_private_link_endpoint_network_policies != null ? null : var.enforce_private_link_service_network_policies

  name                        = var.name
  resource_group_name         = var.resource_group_name
  service_endpoints           = var.service_endpoints
  service_endpoint_policy_ids = var.service_endpoint_policy_ids
  virtual_network_name        = var.virtual_network_name
}
