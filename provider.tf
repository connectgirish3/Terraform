

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}
provider "azurerm" {
  features {}
  subscription_id = "9rtreetr-0556-4654-a470-c9ac0143469a"
  client_id       = "XXXXXXXXXXX1908"
  client_secret   = "FFFFFFFFFFF"
  tenant_id       = "FFFFFFF"
}

