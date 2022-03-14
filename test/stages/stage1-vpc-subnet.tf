
module "dev_pub_subnet" {
  source  = "github.com/cloud-native-toolkit/terraform-aws-vpc-subnets"
  provision=var.provision
  name_prefix = var.name_prefix

  label = "public"
  vpc_name  = module.dev_vpc.vpc_name
  subnet_cidrs              = ["10.0.0.0/20","10.0.125.0/24"]
  availability_zones  =var.availability_zones
  gateways = [module.dev_igw.igw_id]

  map_customer_owned_ip_on_launch = false
  map_public_ip_on_launch         = false
  acl_rules = var.acl_rules

}