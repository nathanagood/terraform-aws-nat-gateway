variable "region"{
  type = string
  default ="ap-south-1" 
  description = "Please set the region where the resouces to be created "
}

variable "access_key"{
  type = string
}
variable "secret_key"{
  type = string

}

variable "cloud_provider" {
  type = string
  default = "ibm"
  
}

variable "provision"{
    type = bool
    description = "Provision to true or false"
    default = false
}

variable "name" {
  type        = string
  description = "The name of the IGW instance"
  default     = "" 
}


variable "name_prefix"{
    type = string
    description = "Prefix to be added to the names of resources which are being provisioned"
    default = "swe"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default     = "default"
}

variable "_count" {
  type = number
  description = "Number of resources to be provisioned"
  default = 1
  
}
variable "connectivity_type" {
  type        = string
  description = "(Optional) Connectivity type for the gateway. Valid values are private and public. Defaults to public."
  default     = "public"  
  
}

# variable "allocation_id" {
#   type        = string
#   description = "(Optional) The Allocation ID of the Elastic IP address for the gateway. Required for connectivity_type of public"
  
# }

# variable "subnet_id" {
#   type        = string
#   description = "(Required) The Subnet ID of the subnet in which to place the gateway."
#   default = ""
# }


variable "instance_tenancy" {
  type        = string
  description = "Instance is shared / dedicated, etc. #[default, dedicated, host]"
  default     = "default"
}

variable "internal_cidr" {
  type        = string
  description = "The cidr range of the internal network.Either provide manually or chose from AWS IPAM poolsß"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  type        = list(string)
  description = "(Required) The CIDR block for the  subnet."
  default     = []
}

# variable "vpc_id" {
#   type        = string
#   description = "The id of the existing VPC instance"
#   default     = ""
# }

variable "subnet_count" {
  type        = number
  description = "Numbers of subnets to provision"
  default     = 0
}

variable "availability_zones" {
  description = "List of availability zone ids"
  type        = list(string)
  default     = [""]
}

variable "acl_rules" {
  type        = list(map(string))
  default = []
}

variable "gateways_count" {
  type = number
  default = 0

}
