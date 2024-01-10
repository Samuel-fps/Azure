# main.tf

# Configuración del proveedor Azure
provider "azurerm" {
  features = {}
}

# Definición del grupo de recursos
resource "azurerm_resource_group" "example" {
  name     = "grupoRecursos"
  location = "East US"
}

# Definición de la red virtual
resource "azurerm_virtual_network" "example" {
  name                = "redVirtual"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Definición de la subred
resource "azurerm_subnet" "example" {
  name                 = "subRed"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Definición de la máquina virtual
resource "azurerm_linux_virtual_machine" "example" {
  name                  = "maquinaVirtual"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  admin_password        = "Password"
  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

# Definición de la interfaz de red
resource "azurerm_network_interface" "example" {
  name                = "interfaz"
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "configuracion"
    subnet_id 
