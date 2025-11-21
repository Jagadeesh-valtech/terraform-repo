variable "resource_group" {
  type = string
  default = "rg-prod-ci"
  description = "Name of the resource group"
}

variable "location" {
  type = string
  default = "southindia"
  description = "Name of the region for hosting resources"
}