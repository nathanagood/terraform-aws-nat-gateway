locals{
  prefix_name  = var.name_prefix != "" && var.name_prefix != null ? var.name_prefix : local.resource_group_name
  resource_group_name = var.resource_group_name != "" && var.resource_group_name != null ? var.resource_group_name : "default"
  ngw_name  = var.name != "" ? var.name : "${local.prefix_name}-ngw"


  ngw_id = var.provision ? aws_nat_gateway.nat_gw.*.id : null
  
  provision_eip = var.connectivity_type == "public" && var.provision && var._count > 0 ?  true : false

  allocation_id =  local.provision_eip ? aws_eip.nat_gw_eip[0].id : var.allocation_id
  
}


##########################################################
# Create NAT Gateway
# For Public NAT gateway, create Elastic IP and add to Nat Gw
##########################################################


resource null_resource print_names {
  count = var.provision ? 1 : 0

  provisioner "local-exec" {
    command = "echo 'ngw_name name: ${local.ngw_name}, Provision EIP: ${local.provision_eip}'"
  }

  provisioner "local-exec" {
    command = "echo 'connectivity_type: ${var.connectivity_type}, Subnet IDs : ${var.subnet_ids[0]}'"
  }
}

resource "aws_nat_gateway" "nat_gw" {
  depends_on = [
    aws_eip.nat_gw_eip
  ]
  count = var.provision && var._count > 0 ?  var._count : 0
  allocation_id =  var.connectivity_type == "public" && length(aws_eip.nat_gw_eip) > 0 ?  element(aws_eip.nat_gw_eip.*.id, count.index) : null
  connectivity_type = var.connectivity_type
  subnet_id = element(var.subnet_ids, count.index)
  tags ={ 
      Name = "${local.ngw_name}-${count.index}",
      ResourceGroup = local.resource_group_name
    }  
}

resource "aws_eip" "nat_gw_eip" {
  count = local.provision_eip  ? var._count : 0
  vpc = true
  tags ={ 
      Name = "${local.prefix_name}-ngw-eip-${count.index}",
      ResourceGroup = local.resource_group_name
    }   

}






