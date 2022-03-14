output "ngw_id" {   
    value = local.ngw_id  
}

output "allocation_id" {   

    value = aws_nat_gateway.nat_gw[*].allocation_id
    description = "The Allocation ID of the Elastic IP address for the gateway."
}

output "subnet_ids" {   
    value = aws_nat_gateway.nat_gw[*].subnet_id  
}

output "network_interface_id" {    
    value = aws_nat_gateway.nat_gw[*].network_interface_id 
}
output "private_ip" {    
    value = aws_nat_gateway.nat_gw[*].private_ip
    description = "The private IP address of the NAT Gateway."
}
output "public_ip" {    
    value = aws_nat_gateway.nat_gw[*].public_ip 
    description = "The public IP address of the NAT Gateway."
}
