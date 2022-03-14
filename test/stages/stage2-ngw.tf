module "dev_pub_ngw" {
  source = "./module"

    _count = var.cloud_provider == "aws"  ? 1 : 0
    provision = var.provision
    resource_group_name = var.resource_group_name
    name_prefix = "${var.name_prefix}-pub"
    connectivity_type = "public"
    subnet_ids = [module.dev_pub_subnet.subnet_ids[0]]    
}

module "dev_priv_ngw" {
  source = "./module"

    _count = var.cloud_provider == "aws"  ? 1 : 0
    provision = var.provision
    resource_group_name = var.resource_group_name
    name_prefix = "${var.name_prefix}-pri"
    connectivity_type = "private"
    subnet_ids = [module.dev_pub_subnet.subnet_ids[1]]
    
}