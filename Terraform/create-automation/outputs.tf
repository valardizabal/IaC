output "resource_group_name" {
  value       = azurerm_resource_group.az_rg.name
  description = "The name of the resource group"
}

output "aa_name" {
  value = azurerm_automation_account.az_aa.name
}

output "aa_mi_name" {
  value = azurerm_automation_account.az_aa.identity
}

output "st_name" {
  value = azurerm_storage_account.az_st.name
}

output "rb_name" {
  value = azurerm_automation_runbook.az_rb.name
}