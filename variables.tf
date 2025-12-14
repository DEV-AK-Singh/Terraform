variable "resource_group_name" {
    description = "Name of the resource group"
    type = string
    default = "terraform-rg"
}

variable "location" {
    description = "Location of the resource group"
    type = string
    default = "Central India"
}

variable "vnet" {
    description = "Name of the virtual network"
    type = string
    default = "terraform-vnet"
}

variable "vnet_address_space" {
    description = "Address space of the virtual network"
    type = list(string)
    default = ["10.0.0.0/16"]
}

variable "subnet" {
    description = "Name of the subnet"
    type = string
    default = "terraform-subnet"
}

variable "subnet_address_prefix" {
    description = "Address prefix of the subnet"
    type = list(string)
    default = ["10.0.1.0/24"]
}

variable "nsg" {
    description = "Name of the network security group"
    type = string
    default = "terraform-nsg"
}

variable "vm_name" {
    description = "Name of the virtual machine"
    type = string
    default = "terraform-vm"
}

variable "vm_size" {
    description = "Size of the virtual machine"
    type = string
    default = "Standard_B1s"
}

variable "admin_user" {
    description = "Admin user of the virtual machine"
    type = string
    default = "azureuser"
}

variable "lb_name" {
    description = "Name of the load balancer"
    type = string
    default = "terraform-lb"
}

variable "lb_frontend_name" {
    description = "Name of the load balancer frontend"
    type = string
    default = "lb-frontend-ip"
}

variable "agw_name" {
    description = "Name of the application gateway"
    type = string
    default = "terraform-agw"
}

variable "agw_subnet" {
    description = "Name of the application gateway subnet"
    type = string
    default = "agw-subnet"
}

variable "agw_subnet_address_prefix" {
    description = "Address prefix of the application gateway subnet"
    type = list(string)
    default = ["10.0.2.0/24"]
}