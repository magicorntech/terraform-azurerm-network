output "vnet_id" {
	value = azurerm_virtual_network.main.id
}

output "pbl_subnet_ids" {
	value = azurerm_subnet.main_pbl.*.id
}

output "pvt_subnet_ids" {
	value = azurerm_subnet.main_pvt.*.id
}

output "aks_subnet_ids" {
	value = azurerm_subnet.main_aks.*.id
}

output "mysql_subnet_ids" {
	value = azurerm_subnet.main_mysql.*.id
}

output "pgsql_subnet_ids" {
	value = azurerm_subnet.main_pgsql.*.id
}

output "mi_subnet_ids" {
	value = azurerm_subnet.main_mi.*.id
}