variable "location" {
    type = string  
    description = "Name of the azure region for hosting resources"
}

variable "resource_group_name" {
  type = string
  description = "Name of the resource group"
}

variable "vmname" {
  type = string
}

variable "network_interface_id" {
  type = list(string)
}

//windows machines
# variable "script_url_with_sas" {
#   type = string
# }

# variable "script_file_name" {
#   type = string
# }

variable "number_of_vms" {
  type = number
}

variable "admin_password" {
  type = string
  sensitive = true
}


variable "ngnix_file_name" {
  type = string
}

variable "ngnix_script_url_with_sas" {
  type = string
}

variable "public_ip_address" {
  type = list(string)
}