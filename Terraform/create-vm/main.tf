terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

resource "azurerm_resource_group" "az_rg" {
  name     = var.az_rg_name
  location = var.az_region
}

resource "azurerm_virtual_network" "az_vm_vnet" {
  name                = var.az_vm_vnet_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "az_vm_subnet" {
  name                 = var.az_vm_subnet_name
  resource_group_name  = azurerm_resource_group.az_rg.name
  virtual_network_name = azurerm_virtual_network.az_vm_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_security_group" "az_vm_nsg" {
  name                = var.az_vm_nsg_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
}

resource "azurerm_network_security_rule" "az_vm_sr" {
  name                        = "security-rule-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.az_rg.name
  network_security_group_name = azurerm_network_security_group.az_vm_nsg.name
}

resource "azurerm_subnet_network_security_group_association" "az_vm_subnet-nsg" {
  subnet_id                 = azurerm_subnet.az_vm_subnet.id
  network_security_group_id = azurerm_network_security_group.az_vm_nsg.id
}

resource "azurerm_public_ip" "az_vm_ip" {
  name                = var.az_vm_ip_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}

resource "azurerm_network_interface" "az_vm_ntc" {
  name                = var.az_vm_ntc_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.az_vm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.az_vm_ip.id
  }
}

resource "azurerm_linux_virtual_machine" "az_vm" {
  name                = var.az_vm_name
  location            = azurerm_resource_group.az_rg.location
  resource_group_name = azurerm_resource_group.az_rg.name
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.az_vm_ntc.id
  ]

  custom_data = filebase64("customdata.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/azurevm_key.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

data "azurerm_public_ip" "az_vm_ip_data" {
  name                = azurerm_public_ip.az_vm_ip.name
  resource_group_name = azurerm_resource_group.az_rg.name
}