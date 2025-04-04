resource "azurerm_subnet" "vpn" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.appflowy.name
  virtual_network_name = azurerm_virtual_network.appflowy.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "vpn" {
  name                = "vpn"
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name

  allocation_method = "Static"
}

resource "azurerm_virtual_network_gateway" "appflowy" {
  name                = "appflowy"
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vpn.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vpn.id
  }

  custom_route {
    address_prefixes = []
  }

  vpn_client_configuration {
    aad_audience = "c632b3df-fb67-4d84-bdcf-b95ad541b5c8"
    aad_issuer   = "https://sts.windows.net/${var.tenant_id}/"
    aad_tenant   = "https://login.microsoftonline.com/${var.tenant_id}/"
    address_space = [
      var.vpn_client_address_space
    ]
    vpn_auth_types = [
      "AAD"
    ]
    vpn_client_protocols = [
      "OpenVPN"
    ]
  }
}
