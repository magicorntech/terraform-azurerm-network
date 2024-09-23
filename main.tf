##### Create Network
resource "azurerm_virtual_network" "main" {
  name                = "${var.tenant}-${var.name}-network-${var.environment}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = [var.address_space]

  tags = {
    Name        = "${var.tenant}-${var.name}-network-${var.environment}"
    Tenant      = var.tenant
    Project     = var.name
    Environment = var.environment
    Maintainer  = "Magicorn"
    Terraform   = "yes"
  }
}