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
variable "delegation" {
  description = "Delegation object to configure the subnet"
  type = list(object({
    name = string
    service_delegation = object({
      name    = string
      actions = list(string)
    })
  }))
  default = null

  validation {
    condition = var.delegation == null || can([
      for o in var.delegation : can(regex("^(Microsoft.ApiManagement/service|Microsoft.AzureCosmosDB/clusters|Microsoft.BareMetal/AzureVMware|Microsoft.BareMetal/CrayServers|Microsoft.Batch/batchAccounts|Microsoft.ContainerInstance/containerGroups|Microsoft.Databricks/workspaces|Microsoft.DBforMySQL/flexibleServers|Microsoft.DBforMySQL/serversv2|Microsoft.DBforPostgreSQL/flexibleServers|Microsoft.DBforPostgreSQL/serversv2|Microsoft.DBforPostgreSQL/singleServers|Microsoft.HardwareSecurityModules/dedicatedHSMs|Microsoft.Kusto/clusters|Microsoft.Logic/integrationServiceEnvironments|Microsoft.MachineLearningServices/workspaces|Microsoft.Netapp/volumes|Microsoft.Network/managedResolvers|Microsoft.PowerPlatform/vnetaccesslinks|Microsoft.ServiceFabricMesh/networks|Microsoft.Sql/managedInstances|Microsoft.Sql/servers|Microsoft.StreamAnalytics/streamingJobs|Microsoft.Synapse/workspaces|Microsoft.Web/hostingEnvironments|Microsoft.Web/serverFarms)$", o.service_delegation.name))
    ])
    error_message = "Please respect the required value given here: <https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet#name>."
  }
}

variable "enforce_private_link_endpoint_network_policies" {
  description = "Enable or Disable network policies for the private link endpoint on the subnet."
  type        = bool
  default     = false
}

variable "enforce_private_link_service_network_policies" {
  description = "Enable or Disable network policies for the private link service on the subnet."
  type        = bool
  default     = false
}

variable "service_endpoints" {
  description = "The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = null

  validation {
    condition = var.service_endpoints == null || can([
      for o in var.service_endpoints : contains(["Microsoft.AzureActiveDirectory", "Microsoft.AzureCosmosDB", "Microsoft.ContainerRegistry", "Microsoft.EventHub", "Microsoft.KeyVault", "Microsoft.ServiceBus", "Microsoft.Sql", "Microsoft.Storage", "Microsoft.Web"], o)
    ])
    error_message = "The variable service_endpoints must be at least one of Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage and Microsoft.Web."
  }
}

variable "service_endpoint_policy_ids" {
  description = "The list of IDs of Service Endpoint Policies to associate with the subnet."
  type        = list(string)
  default     = null
}
