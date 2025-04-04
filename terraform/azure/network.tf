resource "azurerm_virtual_network" "appflowy" {
  name                = "appflowy"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name
}

resource "azurerm_subnet" "appflowy" {
  name                 = "appflowy"
  resource_group_name  = azurerm_resource_group.appflowy.name
  virtual_network_name = azurerm_virtual_network.appflowy.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_public_ip" "appflowy" {
  name                = "appflowy"
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name
  allocation_method   = "Static"
  domain_name_label   = var.domain_name_label
}

resource "azurerm_network_security_group" "appflowy" {
  name                = "appflowy"
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name

  security_rule {
    name                       = "Allow-HTTP"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.ssh_allowed_source
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "appflowy" {
  name                = "appflowy"
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name

  ip_configuration {
    name                          = "appflowy"
    subnet_id                     = azurerm_subnet.appflowy.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.appflowy.id
  }
}

resource "azurerm_network_interface_security_group_association" "appflowy" {
  network_interface_id      = azurerm_network_interface.appflowy.id
  network_security_group_id = azurerm_network_security_group.appflowy.id
}
