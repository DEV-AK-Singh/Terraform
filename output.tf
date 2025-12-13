output "resource_group_name" {
  value = azurerm_resource_group.resource_group.name
}

output "resource_group_location" {
  value = azurerm_resource_group.resource_group.location
}

output "vm_public_ip" {
  value = azurerm_public_ip.vm_pip.ip_address
}

output "vm_nic_ip_config" {
  value = azurerm_network_interface.vm_nic.ip_configuration
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.vm.name
}

output "vm_size" {
  value = azurerm_linux_virtual_machine.vm.size
}

output "vm_admin_user" {
  value = azurerm_linux_virtual_machine.vm.admin_username
}