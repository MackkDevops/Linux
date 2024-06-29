terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.90.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "1d7826c2-a911-438e-b5f4-2a38c7bf147e"
  tenant_id       = "1a3fe338-5139-4a73-badc-d2b3f7981f64"
}
