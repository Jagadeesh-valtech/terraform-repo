variable "location_name" {
  type = string
  description = "Azure region for hosting resources"
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "vnet_name"{
  type = string
}

variable "vnet_address_prefix" {
  type = list(string)
}

variable "snet_name" {
  type = string
}

variable "snet_address_prefixes" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}

variable "network_interface_name" {
  type = string
}

variable "vmname" {
  type = string
}

variable "public_ip_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_contaier_name" {
  type = string
}

variable "number_of_subnets" {
  type = number
}