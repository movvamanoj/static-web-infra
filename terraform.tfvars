region = "us-east-1" 

# VPC Module Variables
vpc_cidr = "10.0.0.0/16"
public_subnet_cidrs_count = "2" 

# public_cidr_block        = "10.0.1${count.index}.0/24"
# private_cidr_block        = "10.0.2${count.index}.0/24"
#subnet_cidrs       = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
#availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

alb_count = "1"

instance_count = "1"
instance_type = "t2.micro"
key_name = "new-trail"
ec2_ami = "ami-079db87dc4c10ac91"
role_name = "static_website_role"
ig_tag_name = "MyIGW-308"  

base_cidr_block = "10.0.1"
cidr_suffix     = ".0/24"
public_subnet_name_tag = "Public-Subnet-308-"

#autoscaling
  asg_name            = "static-web-autoscaling-group"
  min_size            = 1
  max_size            = 3
  desired_capacity    = 2
  launch_config_name  = "my-launch-configuration"
  tag_key             = "Environment"  
  tag_value           = "Production"   
  tag_propagate_at_launch = true
  lifecycle_create_before_destroy = true

  #
public_route_table_tag_name = "Public-Route-Table-staticweb"

target_group_names = "target-group-"
target_group_count = 1
target_instance_count = 2
target_group_port = 80
target_group_protocol = "HTTP"
health_check_path = "/" 
health_check_port = 80
health_check_interval = 30
health_check_healthy_threshold = 3
health_check_unhealthy_threshold = 2

#s3

github_files_url = "https://api.github.com/repos/movvamanoj/static-webhost/contents/"
    #  local_files_path = "path/to/local/files"
    #  github_files     = ["file1.txt", "file2.txt"] 
<<<<<<< HEAD
bucket_name      = "test-terra"
dynamodb_terraform_locks = "terraform-locks"
terraform_tfstate_key = "terraform.tfstate"
s3_terraform_state = "s3-terraform-state-files"
=======
bucket_name      = "test_terra"

#dynamodb


dynamodb_table_name = "test-web-infra"
dynamodb_partition_key = "username"
dynamodb_sort_key = "phone"

#iam

iam_role_name = "static-website-rolename"
>>>>>>> 16c9a7e58f9483c4cc557af98a4d0466f8e7567b
