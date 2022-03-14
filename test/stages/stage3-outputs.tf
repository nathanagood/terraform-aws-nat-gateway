output "vpc_id" {
    value = module.dev_vpc.vpc_id
}

output "vpc_name" {
    value = module.dev_vpc.vpc_name
}

output "public_subnet_ids" {   
    value = module.dev_pub_subnet.subnet_ids
}

output "pub_ngw_id" {   
    value = module.dev_pub_ngw.ngw_id
}

output "pub_allocation_id" {   
    value =  module.dev_pub_ngw.allocation_id 
    description = "The Allocation ID of the Elastic IP address for the gateway."
}
 
output "pub_ngw_subnet_id" {   
    value = module.dev_pub_ngw.subnet_ids     
}

output "pub_ngw_private_ip" {    
    value = module.dev_pub_ngw.private_ip 
    description = "The private IP address of the NAT Gateway."
}
output "pub_ngw_public_ip" {    
    value = module.dev_pub_ngw.public_ip 
    description = "The public IP address of the NAT Gateway."
}


output "priv_ngw_id" {   
    value = module.dev_priv_ngw.ngw_id
}

output "priv_ngw_subnet_id" {   
    value = module.dev_priv_ngw.subnet_ids     
}

output "priv_ngw_private_ip" {    
    value = module.dev_priv_ngw.private_ip 
    description = "The private IP address of the NAT Gateway."
}
output "priv_ngw_public_ip" {    
    value = module.dev_priv_ngw.public_ip 

    description = "The public IP address of the NAT Gateway."
}

resource null_resource write_outputs {
  provisioner "local-exec" {

    command = "echo \"$${OUTPUT}\" > ngw-output.json"
    environment = {
      OUTPUT = jsonencode({
        vpc_name=module.dev_vpc.vpc_name
        vpc_id= module.dev_vpc.vpc_id
        pub_ngw_id= module.dev_pub_ngw.ngw_id[0]
        pub_subnet_id= module.dev_pub_ngw.subnet_ids[0]
        public_ip= module.dev_pub_ngw.public_ip[0]
        pri_ngw_id= module.dev_priv_ngw.ngw_id[0]
        pri_subnet_id= module.dev_priv_ngw.subnet_ids[0]

      })
    }
  }
}
