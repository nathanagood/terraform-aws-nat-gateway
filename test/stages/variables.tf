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

variable "allocation_id" {
  type        = string
  description = "(Optional) The Allocation ID of the Elastic IP address for the gateway. Required for connectivity_type of public"
  
}
variable "subnet_id" {
  type        = string
  description = "(Required) The Subnet ID of the subnet in which to place the gateway."
  default = ""
}

/***/
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


variable "vpc_id" {
  type        = string
  description = "The id of the existing VPC instance"
  default     = ""
}

variable "private_subnet_cidr" {
  type        = list(string)
  description = "(Required) The CIDR block for the private subnet."
  default     = ["10.0.125.0/24"]
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = "(Required) The CIDR block for the public subnet."
  default     = ["10.0.0.0/20"]
}

variable "subnet_count" {
  type        = number
  description = "Numbers of subnets to provision"
  default     = 0
}

variable "tags" {
  type = map(string)
  default = {
    project = "swe"
  }
  description = "(Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
}

variable "public_subnet_tags" {
  description = "Tags for public subnets"
  type        = map(string)
  default = {
    tier = "public"
  }
}

variable "private_subnet_tags" {
  description = "Tags for private subnets"
  type        = map(string)
  default = {
    tier = "private"
  }
}

variable "availability_zones" {
  description = "List of availability zone ids"
  type        = list(string)
  default     = [""]
}

variable "acl_rules_pub_in" {
  type        = list(map(string))
  default = []
}

variable "acl_rules_pub_out" {
  type        = list(map(string))
  default = []
}

variable "acl_rules_pri_in" {
  description = "Private subnets inbound network ACLs"
  type        = list(map(string))
  default = []
}

variable "acl_rules_pri_out" {
  type        = list(map(string))
  default = []
}
