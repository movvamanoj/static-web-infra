# Define an IAM instance profile for EC2 instances.
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = var.iam_role_name
}

# Define EC2 instances with the specified configurations.
resource "aws_instance" "ec2_instance" {
  # Determine if the EC2 should be created based on the instance count.
  count            = var.instance_count > 0 ? var.instance_count : 0
  # AMI and instance type for the EC2 instance.
  ami           = var.ec2_ami 
  instance_type = var.instance_type 
  # Subnet, key name, security groups, and IAM instance profile.
  subnet_id     = var.public_subnet[0]
  key_name      = var.key_name
  security_groups = var.security_groups
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
 
  # User data script for customization on instance launch.
  user_data = <<-EOF
              #!/bin/bash
              set -e
              # Download and execute the shell script from GitHub
              curl -sL https://raw.githubusercontent.com/movvamanoj/static-webhost/main/npm_install_run.sh -o npm_install_run.sh
              sudo chmod +x npm_install_run.sh  # Give execute permissions to the downloaded script
              ./npm_install_run.sh  # Execute the script
              EOF

  # Define tags for the EC2 instance.
  tags = {
    Name = "WebEC2Instance-${count.index + 1}"
  }
}