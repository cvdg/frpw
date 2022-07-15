resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "vn" {
  name                = "${var.prefix}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "sn" {
  name                 = "${var.prefix}-sn"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vn.name
  address_prefixes     = ["10.0.3.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${var.prefix}-public_ip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Dynamic"

}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "141.224.229.148/32"
    destination_address_prefix = "*"
  }
}
resource "azurerm_network_interface" "nic" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  ip_configuration {
    name                          = "ip_cfg"
    subnet_id                     = azurerm_subnet.sn.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nic-nsg" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Size: az vm list-sizes --location westeurope
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = "htb00"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_B1s"
  network_interface_ids = [azurerm_network_interface.nic.id]
  admin_username        = var.username

  admin_ssh_key {
    username   = var.username
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDh7i/cnfg7Kox2N2V/UbpmrboZykA3MmREtVbX+dysFe7X6A7X6623XKoHDbp+G7v14dG5ZBWRwrqYeSoNmQz61Uma1LTfPDPkMV5QRwQK5m9ClWylA17tOPLNXnOzkpACgP9c2tRxBGqjVVQ5YAekXZJtu/A6nP1PW+hLAX3HjrXU8mmLRm4MwAd/WmOXXjRCL2dkAr9tn/JLsFx0B3DuuDlNpshB4n7ewSnikLRKK8mrhBuJZZKiobBhEuzEn7dMqCG9Wlw/oYtyR+hvS6G0NZvnsJM5OMcD97xekrlpp8Rf43wLZWEKf31gHFP+8cthuF+ldbPWFBinVR6ow2clyzMFFDOlFrUI1SJwyGkyZEBo8NTCm4NPVh6y39QHV9dD8ArD4exekzRz6QyJW4+EfJS8p7gSKz9MZfuA8TLu0GsERez32zBbUMmmttzCko46rIMwiiepYYP21ui4njNSxtqtDJ2HBe8TovuChvhhRZh5+0JuwzCeCe92TzBFbgk= cvdg@cvdg.eu"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  # az vm image list --all --location 'West Europe' --publisher debian
  source_image_reference {
    publisher = "Debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }
}
