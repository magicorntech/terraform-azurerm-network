# terraform-azurerm-network

Magicorn made Terraform Module for Azure Provider
--
```
module "network" {
  source      = "magicorntech/network/azurerm"
  version     = "0.0.1"
  tenant      = var.tenant
  name        = var.name
  environment = var.environment
  rg_location = azurerm_resource_group.main.location
  rg_name     = azurerm_resource_group.main.name

  # Network Configuration
  address_space   = "10.32.0.0/16"
  single_az_nat   = false # deploys NAT gateway for each subnet in pvt and aks subnets.
  pbl_sub_count   = [{ address = "10.32.0.0/20" }]
  pvt_sub_count   = [{ address = "10.32.32.0/20" }, { address = "10.32.48.0/20" }]
  aks_sub_count   = [{ address = "10.32.64.0/20" }, { address = "10.32.80.0/20" }]
  mysql_sub_count = [{ address = "10.32.96.0/21" }]
  pgsql_sub_count = [{ address = "10.32.104.0/21" }]
  mi_sub_count    = [{ address = "10.32.112.0/21" }]
}

```