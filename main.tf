provider "azurerm" {
    skip_provider_registration = true 
    features {}
}

data "azurerm_resource_group" "tech258" {
  name = "tech258"
}

resource "azurerm_virtual_network" "two-tier-app-vnet" {
  name                = "tech258-joshg-2-tier-app-vnet"
  address_space       = ["10.3.0.0/16"]
  location            =  data.azurerm_resource_group.tech258.location
  resource_group_name =  data.azurerm_resource_group.tech258.name
}

resource "azurerm_subnet" "two-tier-app-subnet" {
  name                 = "internal"
  resource_group_name  =  data.azurerm_resource_group.tech258.name
  virtual_network_name = azurerm_virtual_network.two-tier-app-vnet.name
  address_prefixes     = ["10.3.2.0/24"]
}

resource "azurerm_network_interface" "two-tier-app-nic" {
  name                = "example-nic"
  location            =  data.azurerm_resource_group.tech258.location
  resource_group_name =  data.azurerm_resource_group.tech258.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.two-tier-app-subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "joshg-vm" {
  name                = "joshg-terraform-vm"
  resource_group_name = data.azurerm_resource_group.tech258.name
  location            =  data.azurerm_resource_group.tech258.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.two-tier-app-nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/tech258_joshg_az_key.pub")
  }

  os_disk {
    caching              = "None"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}