# resource "azurerm_resource_group" "rg" {
#     name     = "test-terraform"
#     location = "Central India"
# }

resource "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  address_space       = var.vnet_address_space
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet
  address_prefixes     = var.subnet_address_prefix
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}

# resource "azurerm_network_security_rule" "allow_ssh" {
#   name                        = "allow_ssh"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "22"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.resource_group.name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }

# resource "azurerm_network_security_rule" "allow_http" {
#   name                        = "allow_http"
#   priority                    = 101
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "80"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.resource_group.name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }

# resource "azurerm_network_security_rule" "allow_https" {
#   name                        = "allow_https"
#   priority                    = 102
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "443"
#   source_address_prefix       = "*"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.resource_group.name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }

# resource "azurerm_network_security_rule" "allow_lb_probe" {
#   name                        = "allow_lb_probe"
#   priority                    = 100
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "80"
#   source_address_prefix       = "AzureLoadBalancer"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.resource_group.name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }

# resource "azurerm_network_security_rule" "allow_client_http" {
#   name                        = "allow_client_http"
#   priority                    = 110
#   direction                   = "Inbound"
#   access                      = "Allow"
#   protocol                    = "Tcp"
#   source_port_range           = "*"
#   destination_port_range      = "80"
#   source_address_prefix       = "Internet"
#   destination_address_prefix  = "*"
#   resource_group_name         = azurerm_resource_group.resource_group.name
#   network_security_group_name = azurerm_network_security_group.nsg.name
# }

resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# resource "azurerm_public_ip" "vm_pip" {
#   name                = "${var.vm_name}-pip"
#   resource_group_name = azurerm_resource_group.resource_group.name
#   location            = azurerm_resource_group.resource_group.location
#   allocation_method   = "Static"
# }

# ------------------------------LOAD BALANCER CONFIGURATION-----------------------------

# resource "azurerm_public_ip" "lb_pip" {
#   name                = "${var.lb_name}-pip"
#   resource_group_name = azurerm_resource_group.resource_group.name
#   location            = azurerm_resource_group.resource_group.location
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_lb" "lb" {
#   name                = var.lb_name
#   resource_group_name = azurerm_resource_group.resource_group.name
#   location            = azurerm_resource_group.resource_group.location
#   sku                 = "Standard"
#   frontend_ip_configuration {
#     name                 = var.lb_frontend_name
#     public_ip_address_id = azurerm_public_ip.lb_pip.id
#   }
# }

# resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
#   name            = "lb-backend-pool"
#   loadbalancer_id = azurerm_lb.lb.id
# }

# resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_assoc" {
#   network_interface_id    = azurerm_network_interface.vm_nic.id
#   ip_configuration_name   = "internal"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
# }

# resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_assoc_x" {
#   network_interface_id    = azurerm_network_interface.vm_nic_x.id
#   ip_configuration_name   = "internal"
#   backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
# }

# resource "azurerm_lb_probe" "http_probe" {
#   name            = "http-probe"
#   loadbalancer_id = azurerm_lb.lb.id
#   port            = 80
#   protocol        = "Tcp"
# }

# resource "azurerm_lb_rule" "http_rule" {
#   name                           = "http-rule"
#   loadbalancer_id                = azurerm_lb.lb.id
#   frontend_ip_configuration_name = var.lb_frontend_name
#   protocol                       = "Tcp"
#   frontend_port                  = 80
#   backend_port                   = 80
#   backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
#   probe_id                       = azurerm_lb_probe.http_probe.id
# }

# ------------------------------APPLICATION GATEWAY CONFIGURATION-----------------------------

resource "azurerm_public_ip" "agw_pip" {
  name                = "${var.agw_name}-pip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_subnet" "agw_subnet" {
  name                 = var.agw_subnet
  resource_group_name  = azurerm_resource_group.resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.agw_subnet_address_prefix
}

resource "azurerm_application_gateway" "agw" {
  name                = var.agw_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2
  }

  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20220101S"
  }

  gateway_ip_configuration {
    name      = "agw-ip-config"
    subnet_id = azurerm_subnet.agw_subnet.id
  }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "public-frontend"
    public_ip_address_id = azurerm_public_ip.agw_pip.id
  }

  backend_address_pool {
    name = "backend-pool" 
  }

  backend_http_settings {
    name                  = "http-settings"
    port                  = 80
    protocol              = "Http"
    cookie_based_affinity = "Disabled"
    request_timeout       = 20
  }

  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "public-frontend"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "rule-1"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 100
  }
}

locals {
  agw_backend_pool_id = one([
    for p in azurerm_application_gateway.agw.backend_address_pool :
    p.id if p.name == "backend-pool"
  ])
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "vm1_agw_assoc" {
  network_interface_id    = azurerm_network_interface.vm_nic.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = local.agw_backend_pool_id
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "vm2_agw_assoc" {
  network_interface_id    = azurerm_network_interface.vm_nic_x.id
  ip_configuration_name   = "internal"
  backend_address_pool_id = local.agw_backend_pool_id
}

resource "azurerm_network_security_rule" "allow_agw" {
  name                        = "allow-agw"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "ApplicationGateway"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.resource_group.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "${var.vm_name}-nic"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }
}

resource "azurerm_network_interface" "vm_nic_x" {
  name                = "${var.vm_name}-nic-x"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    # public_ip_address_id          = azurerm_public_ip.vm_pip.id
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = var.vm_size
  admin_username      = var.admin_user
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]
  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/tf_azure_key.pub")
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

resource "azurerm_linux_virtual_machine" "vm_x" {
  name                = "${var.vm_name}-x"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  size                = var.vm_size
  admin_username      = var.admin_user
  network_interface_ids = [
    azurerm_network_interface.vm_nic_x.id,
  ]
  admin_ssh_key {
    username   = var.admin_user
    public_key = file("~/.ssh/tf_azure_key.pub")
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
