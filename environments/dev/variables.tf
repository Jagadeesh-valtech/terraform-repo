variable "resource_group" {
  type = string
  default = "rg-dev-ci"
  description = "Name of the resource group"
}

variable "location" {
  type = string
  default = "centralindia"
  description = "Name of the region for hosting resources"
}

variable "admin_password" {
  type = string
  sensitive = true
  description = "Password for the VM"
}