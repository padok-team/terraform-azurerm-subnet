variable "name" {
  description = "The name of the subnet. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the virtual network resource group."
  type        = string
}

variable "virtual_network_name" {
  description = "The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
  type        = string
}

variable "address_prefixes" {
  description = "The address prefixes to use for the subnet."
  type        = list(string)
}

# name =>  A name for this delegation.
# service_delegation.name => The name of service to delegate to.
# service_delegation.actions => A list of Actions which should be delegated. This list is specific to the service to delegate to.
variable "delegations" {
  description = "Delegation object to configure the subnet."
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  }))
  default = null
}

variable "enforce_private_link_endpoint_network_policies" {
  description = "Enable or disable network policies for the private link endpoint on the subnet."
  type        = bool
  default     = false
}

variable "enforce_private_link_service_network_policies" {
  description = "Enable or disable network policies for the private link service on the subnet."
  type        = bool
  default     = false
}

variable "service_endpoints" {
  description = "The list of service endpoints to associate with the subnet."
  type        = list(string)
  default     = null
}

variable "service_endpoint_policy_ids" {
  description = "The list of IDs of service endpoint policies to associate with the subnet."
  type        = list(string)
  default     = null
}
