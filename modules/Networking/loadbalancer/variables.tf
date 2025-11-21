variable "location" {
    type = string  
    description = "Name of the azure region for hosting resources"
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "virtual_network_id" {
  type = string
}

variable "number_of_subnets" {
  type = number
}

variable "network_interface_private_ip" {
  type = list(string)
}