data "azurerm_key_vault" "test" {
  name                = "vm-key1234435"
  resource_group_name = "key"
}

data "azurerm_key_vault_secret" "test" {
  name      = "vmpassword1"
  key_vault_id = data.azurerm_key_vault.test.id
}

