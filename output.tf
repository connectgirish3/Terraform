output "rgname" {
  value = azurerm_resource_group.resourcegroup.name
}






output "public_ip" {
  value = azurerm_public_ip.publicip.*.ip_address
}

output "virtual_machine" {
  value = azurerm_windows_virtual_machine.vm.*.name
}

output "secret_value" {
  value = "${data.azurerm_key_vault_secret.test.value}"
}

output "keyvault" {
   value = "${data.azurerm_key_vault.test.id}" 
}