output "resource_group_name" {
  value       = azurerm_resource_group.az_rg.name
  description = "The name of the resource group"
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.az_vm.name
}

output "vnet_name" {
  value = azurerm_virtual_network.az_vm_vnet.name
}

output "vm_nsg_name" {
  value = azurerm_network_security_group.az_vm_nsg.name
}

output "vm_ntc_name" {
  value = azurerm_network_interface.az_vm_ntc.name
}

output "vm_subnet_name" {
  value = azurerm_subnet.az_vm_subnet.name
}

output "vm_public_ip_name" {
  value = "${azurerm_linux_virtual_machine.az_vm.name}: ${data.azurerm_public_ip.az_vm_ip_data.ip_address}"
}
