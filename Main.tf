resource "azurerm_resource_group" "Advik" {
  name     = "Advik"
  location = "Central India"
}
resource "azurerm_virtual_network" "Advik" {
  name                = "Advik"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.Advik.location
  resource_group_name = azurerm_resource_group.Advik.name
}
resource "azurerm_subnet" "Advik" {
  name                 = "Advik"
  resource_group_name  = azurerm_resource_group.Advik.name
  virtual_network_name = azurerm_virtual_network.Advik.name
  address_prefixes     = ["10.0.1.0/24"]
}
resource "azurerm_public_ip" "Advik" {
  name                    = "Advik"
  location                = azurerm_resource_group.Advik.location
  resource_group_name     = azurerm_resource_group.Advik.name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
}
resource "azurerm_network_interface" "Advik" {
  name                = "Advik"
  location            = azurerm_resource_group.Advik.location
  resource_group_name = azurerm_resource_group.Advik.name
  ip_configuration {
    name                          = "Advik"
    subnet_id                     = azurerm_subnet.Advik.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.Advik.id
  }
}
resource "azurerm_network_security_group" "Advik" {
  name                = "Advik"
  location            = azurerm_resource_group.Advik.location
  resource_group_name = azurerm_resource_group.Advik.name
  security_rule {
    name                       = "Advik"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface_security_group_association" "Advik" {
  network_interface_id      = azurerm_network_interface.Advik.id
  network_security_group_id = azurerm_network_security_group.Advik.id
}
resource "azurerm_virtual_machine" "Advik" {
  name                             = "Advik"
  location                         = azurerm_resource_group.Advik.location
  resource_group_name              = azurerm_resource_group.Advik.name
  network_interface_ids            = [azurerm_network_interface.Advik.id]
  vm_size                          = "Standard_DS1_v2"
  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true
  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "Advik"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "Advik"
    admin_username = "Advik"
    admin_password = "@dvikRoy2711"
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}