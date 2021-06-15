terraform {
  backend "azurerm" {
    resource_group_name  = "storageaccount"
    storage_account_name = "insdadhop1"
    container_name       = "test"
    key                  = "test.terraform.tfstate"
  }
}