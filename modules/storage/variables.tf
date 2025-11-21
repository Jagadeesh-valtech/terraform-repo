
variable "location" {
    type = string  
    description = "Name of the azure region for hosting resources"
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "storage_account_name" {
  type = string
}

variable "storage_contaier_name" {
  type = string
}
