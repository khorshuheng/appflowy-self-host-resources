resource "azapi_resource_action" "ssh_public_key_gen" {
  type        = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  resource_id = azapi_resource.ssh_public_key.id
  action      = "generateKeyPair"
  method      = "POST"

  response_export_values = ["publicKey", "privateKey"]
}

resource "azapi_resource" "ssh_public_key" {
  type      = "Microsoft.Compute/sshPublicKeys@2022-11-01"
  name      = "appflowy-ssh-key"
  location  = azurerm_resource_group.appflowy.location
  parent_id = azurerm_resource_group.appflowy.id
}

output "generated_ssh_private_key" {
  value     = azapi_resource_action.ssh_public_key_gen.output["privateKey"]
  sensitive = true
}
