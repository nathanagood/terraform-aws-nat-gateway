output "vpc_id" {
    value = module.dev_vpc.vpc_id
}
output "ngw_id" {   
    value = module.dev_ngw.ngw_id 
}

output "allocation_id" {   
    value = module.dev_ngw.allocation_id 
    description = "The Allocation ID of the Elastic IP address for the gateway."
}
 
output "subnet_id" {   
    value = module.dev_ngw.subnet_id     
}

output "network_interface_id" {    
    value = module.dev_ngw.network_interface_id 
}
output "private_ip" {    
    value = module.dev_ngw.private_ip 
    description = "The private IP address of the NAT Gateway."
}
output "public_ip" {    
    value = module.dev_ngw.public_ip 
    description = "The public IP address of the NAT Gateway."
}

resource null_resource write_outputs {
  provisioner "local-exec" {
    command = "echo \"$${OUTPUT}\" > igw-output.json"
    environment = {
      OUTPUT = jsonencode({
        # vpc_name=module.dev_vpc.vpc[0].tags["Name"]
        vpc_id= module.dev_vpc.vpc_id
        ngw_id= module.dev_ngw.ngw_id  
        allocation_id= module.dev_ngw.allocation_id    
        subnet_id= module.dev_ngw.subnet_id    
        network_interface_id= module.dev_ngw.network_interface_id    
        private_ip= module.dev_ngw.private_ip 
        public_ip= module.dev_ngw.public_ip 
        
      })
    }
  }
}
