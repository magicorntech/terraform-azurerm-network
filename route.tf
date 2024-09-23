##### Create Public Route Table
resource "azurerm_route_table" "main_pbl" {
  name                          = "${var.tenant}-${var.name}-pbl-route-${var.environment}"
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  bgp_route_propagation_enabled = true

  route {
    name           = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "Internet"
  }

  lifecycle {
    ignore_changes = [route]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-pbl-route-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create Private Route Table
resource "azurerm_route_table" "main_pvt" {
  count                         = (length(var.pvt_sub_count) > 0) ? 1 : 0
  name                          = "${var.tenant}-${var.name}-pvt-route-${var.environment}"
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  bgp_route_propagation_enabled = true

  lifecycle {
    ignore_changes = [route]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-pvt-route-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create AKS Route Table
resource "azurerm_route_table" "main_aks" {
  count                         = (length(var.aks_sub_count) > 0) ? 1 : 0
  name                          = "${var.tenant}-${var.name}-aks-route-${var.environment}"
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  bgp_route_propagation_enabled = true

  lifecycle {
    ignore_changes = [route]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-aks-route-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create MySQL Route Table
resource "azurerm_route_table" "main_mysql" {
  count                         = (length(var.mysql_sub_count) > 0) ? 1 : 0
  name                          = "${var.tenant}-${var.name}-mysql-route-${var.environment}"
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  bgp_route_propagation_enabled = true

  lifecycle {
    ignore_changes = [route]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-mysql-route-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create PostgreSQL Route Table
resource "azurerm_route_table" "main_pgsql" {
  count                         = (length(var.pgsql_sub_count) > 0) ? 1 : 0
  name                          = "${var.tenant}-${var.name}-pgsql-route-${var.environment}"
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  bgp_route_propagation_enabled = true

  lifecycle {
    ignore_changes = [route]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-pgsql-route-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create AzureSQL Managed Instance Route Table
resource "azurerm_route_table" "main_mi" {
  count                         = (length(var.mi_sub_count) > 0) ? 1 : 0
  name                          = "${var.tenant}-${var.name}-mi-route-${var.environment}"
  location                      = var.rg_location
  resource_group_name           = var.rg_name
  bgp_route_propagation_enabled = true

  lifecycle {
    ignore_changes = [route]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-mi-route-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Route Table Association for Public Subnets
resource "azurerm_subnet_route_table_association" "main_pbl_route_association" {
  count          = length(var.pbl_sub_count)
  subnet_id      = element(azurerm_subnet.main_pbl.*.id, count.index)
  route_table_id = azurerm_route_table.main_pbl.id
}

##### Route Table Association for Private Subnets
resource "azurerm_subnet_route_table_association" "main_pvt_route_association" {
  count          = length(var.pvt_sub_count)
  subnet_id      = element(azurerm_subnet.main_pvt.*.id, count.index)
  route_table_id = azurerm_route_table.main_pvt[0].id
}

##### Route Table Association for AKS Subnets
resource "azurerm_subnet_route_table_association" "main_aks_route_association" {
  count          = length(var.aks_sub_count)
  subnet_id      = element(azurerm_subnet.main_aks.*.id, count.index)
  route_table_id = azurerm_route_table.main_aks[0].id
}

##### Route Table Association for MySQL Subnets
resource "azurerm_subnet_route_table_association" "main_mysql_route_association" {
  count          = length(var.mysql_sub_count)
  subnet_id      = element(azurerm_subnet.main_mysql.*.id, count.index)
  route_table_id = azurerm_route_table.main_mysql[0].id
}

##### Route Table Association for PgSQL Subnets
resource "azurerm_subnet_route_table_association" "main_pgsql_route_association" {
  count          = length(var.pgsql_sub_count)
  subnet_id      = element(azurerm_subnet.main_pgsql.*.id, count.index)
  route_table_id = azurerm_route_table.main_pgsql[0].id
}

##### Route Table Association for Managed Instance Subnets
resource "azurerm_subnet_route_table_association" "main_mi_route_association" {
  count          = length(var.mi_sub_count)
  subnet_id      = element(azurerm_subnet.main_mi.*.id, count.index)
  route_table_id = azurerm_route_table.main_mi[0].id
}
