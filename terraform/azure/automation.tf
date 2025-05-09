resource "azurerm_user_assigned_identity" "appflowy_automation" {
  name                = "appflowy_automation"
  resource_group_name = azurerm_resource_group.appflowy.name
  location            = azurerm_resource_group.appflowy.location
}

resource "azurerm_role_assignment" "appflowy_automation" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.appflowy_automation.principal_id
}

resource "azurerm_role_assignment" "appflowy_automation_vault_key_reader" {
  scope                = azurerm_key_vault.appflowy.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.appflowy_automation.principal_id
}

resource "azurerm_automation_runbook" "appflowy_env" {
  name                    = "CreateAppFlowyEnvFile"
  location                = azurerm_resource_group.appflowy.location
  resource_group_name     = azurerm_resource_group.appflowy.name
  automation_account_name = var.automation_account_name
  log_verbose             = true
  log_progress            = true
  runbook_type            = "PowerShell"

  content = templatefile("${path.module}/template/update_env.ps1", {
    resource_group_name            = azurerm_resource_group.appflowy.name
    vm_name                        = azurerm_linux_virtual_machine.appflowy.name
    client_id                      = azurerm_user_assigned_identity.appflowy_automation.client_id
    vault_name                     = azurerm_key_vault.appflowy.name
    appflowy_env_secret_name       = azurerm_key_vault_secret.appflowy_env_base64.name
    appflowy_site_conf_secret_name = azurerm_key_vault_secret.appflowy_site_conf_base64.name
    docker_hub_password            = var.docker_hub_password
  })
}
