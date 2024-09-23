##### Create NAT IPs
resource "azurerm_public_ip" "nat_gateway" {
  count               = local.nat_count
  name                = local.nat_count == 1 ? "${var.tenant}-${var.name}-natgw-pblip-${var.environment}" : "${var.tenant}-${var.name}-natgw-pblip-${count.index + 1}-${var.environment}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  zones               = ["${count.index + 1}"]

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name        = local.nat_count == 1 ? "${var.tenant}-${var.name}-natgw-pblip-${var.environment}" : "${var.tenant}-${var.name}-natgw-pblip-${count.index + 1}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### Create NAT Gateway
resource "azurerm_nat_gateway" "main" {
  count                   = local.nat_count
  name                    = local.nat_count == 1 ? "${var.tenant}-${var.name}-natgw-${var.environment}" : "${var.tenant}-${var.name}-natgw-${count.index + 1}-${var.environment}"
  location                = var.rg_location
  resource_group_name     = var.rg_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 5
  zones                   = ["${count.index + 1}"]

  tags = {
    Name        = local.nat_count == 1 ? "${var.tenant}-${var.name}-natgw-${var.environment}" : "${var.tenant}-${var.name}-natgw-${count.index + 1}-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

##### NAT Gateway IP Associations
resource "azurerm_nat_gateway_public_ip_association" "main" {
  count                = local.nat_count
  nat_gateway_id       = element(azurerm_nat_gateway.main.*.id, count.index)
  public_ip_address_id = element(azurerm_public_ip.nat_gateway.*.id, count.index)
}

##### NAT Gateway Subnet Associations
resource "azurerm_subnet_nat_gateway_association" "pvt" {
  count          = local.nat_count
  subnet_id      = element(azurerm_subnet.main_pvt.*.id, count.index)
  nat_gateway_id = element(azurerm_nat_gateway.main.*.id, count.index)
}

resource "azurerm_subnet_nat_gateway_association" "aks" {
  count          = local.nat_count
  subnet_id      = element(azurerm_subnet.main_aks.*.id, count.index)
  nat_gateway_id = element(azurerm_nat_gateway.main.*.id, count.index)
}

# resource "azurerm_subnet_nat_gateway_association" "mysql" {
#   count          = local.nat_count
#   subnet_id      = element(azurerm_subnet.main_mysql.*.id, count.index)
#   nat_gateway_id = element(azurerm_nat_gateway.main.*.id, count.index)
# }
