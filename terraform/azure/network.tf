resource "azurerm_virtual_network" "appflowy" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name
}

# Create subnet
resource "azurerm_subnet" "appflowy" {
  name                 = var.virtual_network_name
  resource_group_name  = azurerm_resource_group.appflowy.name
  virtual_network_name = azurerm_virtual_network.appflowy.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "appflowy" {
  name                = var.public_ip_name
  location            = azurerm_resource_group.appflowy.location
  resource_group_name = azurerm_resource_group.appflowy.name
  allocation_method   = "Static"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "appflowy" {
  name                = var.security_group_name
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
    source_address_prefix      = "10.0.2.0/24"
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
  name                = var.network_interface_name
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
