terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "az_rg" {
  name     = var.az_rg_name
  location = var.az_region
}

resource "azurerm_automtion_account" "az_aa" {
  name                = var.az_aa_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  sku_name            = "Basic"
  identity = {
    type = "SystemAssigned"
  }
}

resource "azurerm_automation_runbook" "az_rb" {
  name                    = var.az_rb_name
  location                = azurerm_resource_group.az_rg.location
  resource_group_name     = azurerm_resource_group.az_rg.name
  automation_account_name = azurerm_automation_account.az_aa.name
  log_verbose             = "true"
  log_progress            = "true"
  description             = "This is an example runbook"
  runbook_type            = "PowerShell72"
}

resource "azurerm_storage_account" "az-st" {
  name                     = var.az_st_name
  location                 = azurerm_resource_group.az_rg.location
  resource_group_name      = azurerm_resource_group.az_rg.name
  account_tier             = "Standard"
  account_replication_type = "GRS"
}