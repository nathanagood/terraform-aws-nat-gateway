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
# variable "vpc_name" {
#   type = string
#   description =  "The name of the VPC instance"
  
# }

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group where the VPC is deployed. On AWS this value becomes a tag."
  default     = "default"
}
variable "provision" {
  type =  bool
  description = "Flag to determine whether to provision Internet gateway or not. Defautl set to true"
  default = true
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

variable "allocation_id" {
  type        = string
  description = "(Optional) The Allocation ID of the Elastic IP address for the gateway. Required for connectivity_type of public"
  
  
}
variable "subnet_id" {
  type        = string
  
  description = "(Required) The Subnet ID of the subnet in which to place the gateway."
  
  
}

# variable "tags" {
#   type        = map(string)
#   description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
# }