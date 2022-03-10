module "dev_ngw" {
  source = "./module"

    _count = var.cloud_provider == "aws" ? 1 : 0
    provision = var.provision
    resource_group_name = var.resource_group_name
    name_prefix = var.name_prefix
    connectivity_type = var.connectivity_type
    allocation_id = var.allocation_id
    subnet_id = module.dev_vpc_subnet.public_subnet_ids[0]
    
    
}