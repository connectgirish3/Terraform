
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resourcename
  location = var.location
  tags     = var.tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = "example-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
}


resource "azurerm_subnet" "subnet" {
  count= var.vm_count ? 2 : 1
  name                 = "subnet${count.index}"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [element(var.subnet_space,count.index)]
  
}

resource "azurerm_public_ip" "publicip" {
  count= var.vm_count ? 2 : 1
  name                = "publicip${count.index}"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method   = "Static"
}

resource "azurerm_network_security_group" "nsgrule" {
  name                = "Azurenetworkecuritygrouprules"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location

  dynamic "security_rule" {
    iterator = rule
    for_each = var.networkrule
    content {
      name                       = rule.value.name
      priority                   = rule.value.priority
      direction                  = rule.value.direction
      access                     = rule.value.access
      protocol                   = rule.value.protocol
      source_port_range          = rule.value.source_port_range
      destination_port_range     = rule.value.destination_port_range
      source_address_prefix      = rule.value.source_address_prefix
      destination_address_prefix = rule.value.destination_address_prefix

    }
  }
}
resource "azurerm_network_interface_security_group_association" "nic_association" {
  count = var.vm_count ? 2 : 1
  network_interface_id      = element(azurerm_network_interface.nic.*.id,count.index)
  network_security_group_id = element(azurerm_network_security_group.nsgrule.*.id,count.index)
}
resource "azurerm_network_interface" "nic" {
  count= var.vm_count ? 2 : 1
  name                = "nic${count.index}"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = element(azurerm_subnet.subnet.*.id, count.index)
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id=element(azurerm_public_ip.publicip.*.id, count.index)

  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  count= var.vm_count ? 2 : 1
  name                = "vm-machine${count.index}"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    element(azurerm_network_interface.nic.*.id, count.index)
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}





