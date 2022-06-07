module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "3.14.0"

  name = "${var.cluster_name}-vpc"

  cidr = var.vpc_cidr
  azs  = var.vpc_azs

  private_subnets     = var.vpc_private_subnets
  private_subnet_suffix = "private-subnet"
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
    "Tier" = "private"
  }

  public_subnets      = var.vpc_public_subnets
  public_subnet_suffix = "public-subnet"
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
    "Tier" = "public"
  }

  intra_subnets       = var.vpc_intra_subnets
  intra_subnet_suffix = "intra-subnet"
  intra_subnet_tags = {
    "Tier" = "intra"
  }

  create_database_subnet_group = false
  create_elasticache_subnet_group = false
  create_redshift_subnet_group = false

  map_public_ip_on_launch = false
  enable_dns_hostnames = true
  enable_dns_support   = true
  enable_nat_gateway = true
  single_nat_gateway = true

  # Cloudwatch log group and IAM role will be created
  # enable_flow_log                      = true
  # create_flow_log_cloudwatch_log_group = true
  # create_flow_log_cloudwatch_iam_role  = true
  # flow_log_max_aggregation_interval    = 60

  # vpc_flow_log_tags = {
  #   Name = "vpc-flow-logs-cloudwatch-logs-default"
  # }

  tags = {
    "cluster" = var.cluster_name
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "pipeline" = "lab-platform-vpc" 
  }
}

