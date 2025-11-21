terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.53.0"
    }
  }
#   backend "azurerm" {
#     resource_group_name = "rg-north-europe"
#     storage_account_name = "valtech102021"
#     container_name       = "scripts"
#     key = "terraform.tfstate"
#   }
}

provider "azurerm" {
  # Configuration options
  features {
    
  }
  subscription_id = "727d642f-4c38-4106-8076-d0c863b5b62b"
}