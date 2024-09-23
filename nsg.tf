resource "azurerm_network_security_group" "mi" {
  count               = length(var.mi_sub_count)
  name                = "${var.tenant}-${var.name}-mi-nsg-${var.environment}"
  resource_group_name = var.rg_name
  location            = var.rg_location

  # security_rule {
  #   name                       = "allow_management_inbound"
  #   priority                   = 106
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_ranges    = ["9000", "9003", "1438", "1440", "1452"]
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "allow_misubnet_inbound"
  #   priority                   = 200
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = var.address_space
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "allow_health_probe_inbound"
  #   priority                   = 300
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = "AzureLoadBalancer"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "allow_tds_inbound"
  #   priority                   = 1000
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_range     = "1433"
  #   source_address_prefix      = "VirtualNetwork"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "allow_management_outbound"
  #   priority                   = 102
  #   direction                  = "Outbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_ranges    = ["80", "443", "12000"]
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  # security_rule {
  #   name                       = "allow_misubnet_outbound"
  #   priority                   = 200
  #   direction                  = "Outbound"
  #   access                     = "Allow"
  #   protocol                   = "*"
  #   source_port_range          = "*"
  #   destination_port_range     = "*"
  #   source_address_prefix      = var.address_space
  #   destination_address_prefix = "*"
  # }

  lifecycle {
    ignore_changes = [
      security_rule
    ]
  }

  tags = {
    Name        = "${var.tenant}-${var.name}-mi-nsg-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}

resource "azurerm_subnet_network_security_group_association" "mi" {
  count                     = length(var.mi_sub_count)
  subnet_id                 = azurerm_subnet.main_mi[0].id
  network_security_group_id = azurerm_network_security_group.mi[0].id
}
