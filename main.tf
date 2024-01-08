
module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
}

module "public_subnet" {
    source = "./modules/public_subnet"
    vpc_id   = module.vpc.vpc_id
    base_cidr_block      = var.base_cidr_block
    cidr_suffix          = var.cidr_suffix
    public_subnet_name_tag = var.public_subnet_name_tag
    public_subnet_cidrs_count = var.public_subnet_cidrs_count
}

module "ec2_instance" {
    source = "./modules/ec2"
    iam_role_name = module.iam.iam_role_name
    vpc_id = module.vpc.vpc_id
    public_subnet = module.public_subnet.public_subnet_ids
    instance_count = var.instance_count
    instance_type = var.instance_type
    ec2_ami = var.ec2_ami
    key_name = var.key_name
    security_groups = [module.security_groups.security_group_id] 
}

module "route_tables" {
    source = "./modules/route_tables"
    vpc_id     = module.vpc.vpc_id
    public_route_table_tag_name = var.public_route_table_tag_name
    gateway_id = module.internet_gateway.igw_id
    public_subnet = module.public_subnet.public_subnet_ids
    public_subnet_cidrs_count = var.public_subnet_cidrs_count
}

module "internet_gateway" {
    source = "./modules/internet_gateway"
    vpc_id     = module.vpc.vpc_id
    ig_tag_name = var.ig_tag_name

  
}

module "security_groups" {
    source = "./modules/security_group"
    vpc_id = module.vpc.vpc_id

  
}

module "alb" {
    source = "./modules/Alb"
    vpc_id              = module.vpc.vpc_id
    aws_instance_ids    = module.ec2_instance.ec2_instance_ids
    target_group_arns   = module.target_group.target_group_arns
    security_groups     = [module.security_groups.security_group_id]
    target_group_count = var.target_group_count
    instance_count = var.instance_count
    alb_count = var.alb_count
    subnet_availability_zones = module.public_subnet.subnet_availability_zones
    public_subnet_cidrs_count = var.public_subnet_cidrs_count
    public_subnet = module.public_subnet.public_subnet_ids
    az_count = length(data.aws_availability_zones.available.names)
}

module "asg" {
    source = "./modules/Autoscaling"
    region              = var.region
    asg_name            = var.asg_name
    min_size            = var.min_size
    max_size            = var.max_size
    desired_capacity    = var.desired_capacity
    launch_config_name  = var.launch_config_name
    instance_type       = var.instance_type
    ec2_ami             = var.ec2_ami
    public_subnet       = module.public_subnet.public_subnet_ids
    tag_key             = var.key_name
    tag_value           = var.tag_value 
    tag_propagate_at_launch = var.tag_propagate_at_launch
}

module "target_group" {
    source = "./modules/target_groups"
    vpc_id                           = module.vpc.vpc_id
    aws_instance_ids                 = module.ec2_instance.ec2_instance_ids
    target_group_names               = var.target_group_names
    target_group_count               = var.target_group_count
    target_instance_count            = var.target_instance_count
    target_group_port                = var.target_group_port
    target_group_protocol            = var.target_group_protocol
    health_check_path                = var.health_check_path
    health_check_port                = var.health_check_port
    health_check_interval            = var.health_check_interval
    health_check_healthy_threshold   = var.health_check_healthy_threshold
    health_check_unhealthy_threshold = var.health_check_unhealthy_threshold

  
}

module "iam" {
    source = "./modules/IAM"
    role_name = var.role_name
}

module "dynamodb_table" {
  source                 = "./modules/RDS/Dynamodb"
  dynamodb_table_name    = var.dynamodb_table_name
  dynamodb_partition_key = var.dynamodb_partition_key
  dynamodb_sort_key      = var.dynamodb_sort_key
  dynamodb_terraform_locks = var.dynamodb_terraform_locks
}

module "s3_bucket" {
     source          = "./modules/s3"
     s3_role_name    = module.iam.s3_role_name
     s3_role_arn     = module.iam.s3_role_arn
    #  local_files_path = "path/to/local/files"
    #  github_files     = ["file1.txt", "file2.txt"] 
     bucket_name      = var.bucket_name
     s3_bucket_name = var.s3_terraform_state
     github_files_url = var.github_files_url
}
