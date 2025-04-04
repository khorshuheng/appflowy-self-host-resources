resource "azurerm_resource_group" "appflowy" {
  location = var.location
  name     = var.resource_group_name
}

resource "azurerm_linux_virtual_machine" "appflowy" {
  name                  = "appflowy"
  location              = azurerm_resource_group.appflowy.location
  resource_group_name   = azurerm_resource_group.appflowy.name
  network_interface_ids = [azurerm_network_interface.appflowy.id]
  size                  = "Standard_D2ls_v5"

  custom_data = base64encode(
    templatefile("${path.module}/template/cloud-init", {
  }))

  os_disk {
    name                 = "appflowy"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  computer_name  = "appflowy"
  admin_username = "appflowy"

  admin_ssh_key {
    username   = "appflowy"
    public_key = azapi_resource_action.ssh_public_key_gen.output.publicKey
  }

  identity {
    type = "SystemAssigned"
  }
}
