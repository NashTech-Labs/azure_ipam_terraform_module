output "ipam_reservation" {
  value = azureipam_reservation.multiclient-vnet
}

output "vnet" {
  value = azurerm_virtual_network.vnet
}