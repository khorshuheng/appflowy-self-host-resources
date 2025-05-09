locals {
  fqdn = "${var.domain_name_label}.${var.location}.cloudapp.azure.com"
}

resource "azurerm_key_vault" "appflowy" {
  name                      = "appflowy"
  location                  = azurerm_resource_group.appflowy.location
  resource_group_name       = azurerm_resource_group.appflowy.name
  tenant_id                 = data.azurerm_client_config.current.tenant_id
  sku_name                  = "standard"
  enable_rbac_authorization = true
}

resource "azurerm_role_assignment" "terraform_vault_key_admin" {
  scope                = azurerm_key_vault.appflowy.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "random_password" "postgres_password" {
  length  = 16
  special = false
}

resource "random_password" "supabase_auth_password" {
  length  = 16
  special = false
}

resource "random_password" "admin_user_password" {
  length  = 16
  special = false
}

resource "random_password" "minio_secret" {
  length  = 16
  special = false
}

resource "random_password" "gotrue_jwt_secret" {
  length  = 16
  special = false
}

resource "random_password" "gotrue_admin_password" {
  length  = 16
  special = false
}

resource "azurerm_key_vault_secret" "appflowy_env_base64" {
  depends_on = [azurerm_role_assignment.terraform_vault_key_admin]
  name       = "appflowyEnvBase64"
  value = base64encode(
    templatefile("${path.module}/template/appflowy.env", {
      fqdn                   = local.fqdn
      postgres_password      = random_password.postgres_password.result
      supabase_auth_password = random_password.supabase_auth_password.result
      admin_user_password    = random_password.admin_user_password.result
      gotrue_admin_password  = random_password.gotrue_admin_password.result
      minio_secret           = random_password.minio_secret.result
      gotrue_jwt_secret      = random_password.gotrue_jwt_secret.result
      smtp_host              = var.smtp_host
      smtp_port              = var.smtp_port
      smtp_user              = var.smtp_user
      smtp_admin_email       = var.smtp_email
      smtp_password          = var.smtp_password
      smtp_tls_kind          = var.smtp_tls_kind
      azure_open_ai_key      = var.azure_open_ai_key
      azure_open_ai_endpoint = var.azure_open_ai_endpoint
      azure_open_ai_version  = var.azure_open_ai_version
  }))
  key_vault_id = azurerm_key_vault.appflowy.id
}

resource "azurerm_key_vault_secret" "appflowy_site_conf_base64" {
  depends_on = [azurerm_role_assignment.terraform_vault_key_admin]
  name       = "appflowySiteConfBase64"
  value = base64encode(
    templatefile("${path.module}/template/appflowy-cloud-site.conf", {
      fqdn = local.fqdn
  }))
  key_vault_id = azurerm_key_vault.appflowy.id
}
