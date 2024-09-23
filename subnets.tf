##### Create Public Subnets
resource "azurerm_subnet" "main_pbl" {
  count                = length(var.pbl_sub_count)
  name                 = length(var.pbl_sub_count) == 1 ? "${var.tenant}-${var.name}-snet-pbl-${var.environment}" : "${var.tenant}-${var.name}-snet-pbl-${count.index + 1}-${var.environment}"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [lookup(var.pbl_sub_count[count.index], "address")]
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"

  lifecycle {
    ignore_changes = [
      delegation,
      service_endpoints
    ]
  }
}

##### Create Private Subnets
resource "azurerm_subnet" "main_pvt" {
  count                                         = length(var.pvt_sub_count)
  name                                          = length(var.pvt_sub_count) == 1 ? "${var.tenant}-${var.name}-snet-pvt-${var.environment}" : "${var.tenant}-${var.name}-snet-pvt-${count.index + 1}-${var.environment}"
  resource_group_name                           = var.rg_name
  virtual_network_name                          = azurerm_virtual_network.main.name
  address_prefixes                              = [lookup(var.pvt_sub_count[count.index], "address")]
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"

  lifecycle {
    ignore_changes = [
      delegation,
      service_endpoints
    ]
  }
}

##### Create AKS Subnets
resource "azurerm_subnet" "main_aks" {
  count                                         = length(var.aks_sub_count)
  name                                          = length(var.aks_sub_count) == 1 ? "${var.tenant}-${var.name}-snet-aks-${var.environment}" : "${var.tenant}-${var.name}-snet-aks-${count.index + 1}-${var.environment}"
  resource_group_name                           = var.rg_name
  virtual_network_name                          = azurerm_virtual_network.main.name
  address_prefixes                              = [lookup(var.aks_sub_count[count.index], "address")]
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"

  lifecycle {
    ignore_changes = [
      delegation,
      service_endpoints
    ]
  }
}

##### Create MySQL Subnets
resource "azurerm_subnet" "main_mysql" {
  count                                         = length(var.mysql_sub_count)
  name                                          = length(var.mysql_sub_count) == 1 ? "${var.tenant}-${var.name}-snet-mysql-${var.environment}" : "${var.tenant}-${var.name}-snet-mysql-${count.index + 1}-${var.environment}"
  resource_group_name                           = var.rg_name
  virtual_network_name                          = azurerm_virtual_network.main.name
  address_prefixes                              = [lookup(var.mysql_sub_count[count.index], "address")]
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"
  service_endpoints                             = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

  lifecycle {
    ignore_changes = [
      delegation,
      service_endpoints
    ]
  }
}

##### Create PostgreSQL Subnets
resource "azurerm_subnet" "main_pgsql" {
  count                                         = length(var.pgsql_sub_count)
  name                                          = length(var.pgsql_sub_count) == 1 ? "${var.tenant}-${var.name}-snet-pgsql-${var.environment}" : "${var.tenant}-${var.name}-snet-pgsql-${count.index + 1}-${var.environment}"
  resource_group_name                           = var.rg_name
  virtual_network_name                          = azurerm_virtual_network.main.name
  address_prefixes                              = [lookup(var.pgsql_sub_count[count.index], "address")]
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"
  service_endpoints                             = ["Microsoft.Storage"]

  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }

  lifecycle {
    ignore_changes = [
      delegation,
      service_endpoints
    ]
  }
}

##### Create AzureSQL Managed Instance Subnets
resource "azurerm_subnet" "main_mi" {
  count                                         = length(var.mi_sub_count)
  name                                          = length(var.mi_sub_count) == 1 ? "${var.tenant}-${var.name}-snet-mi-${var.environment}" : "${var.tenant}-${var.name}-snet-mi-${count.index + 1}-${var.environment}"
  resource_group_name                           = var.rg_name
  virtual_network_name                          = azurerm_virtual_network.main.name
  address_prefixes                              = [lookup(var.mi_sub_count[count.index], "address")]
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies             = "Enabled"

  delegation {
    name = "managedinstancedelegation"
    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }

  lifecycle {
    ignore_changes = [
      delegation,
      service_endpoints
    ]
  }
}
