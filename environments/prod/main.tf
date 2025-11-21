module "dev-resource-group" {
  source = "../../modules/general/resourcegroup"
  resource_group_name = var.resource_group
  location = var.location
}

module "storageaccont" {
  source = "../../modules/storage"
  location = var.location
  resource_group_name = var.resource_group
  storage_account_name = "tfprodstorage1997"
  storage_contaier_name = "scripts"
}