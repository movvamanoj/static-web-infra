resource "aws_lb" "my_alb" {

  # Determine if the ALB should be created based on the instance count.
  count = var.instance_count > 0 ? 1 : 0
  name               = "my-alb-${count.index + 1}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  enable_deletion_protection = false # Change as needed
  # Enable HTTP/2 protocol for the ALB.
  enable_http2       = true
  
  # subnets = slice(var.public_subnet, 0, var.az_count)
  # subnets            = slice(var.public_subnet, count.index * var.public_subnet_cidrs_count, (count.index + 1) * var.public_subnet_cidrs_count)
  
  # Create a list of subnets using a dynamic list comprehension.
  subnets = [ 
    for az_index in range(var.az_count) : var.public_subnet[az_index % length(var.public_subnet)]
  ]
}

# Define AWS ALB Target Group Attachments for instances.
resource "aws_lb_target_group_attachment" "alb_target_attachment" {
  # Create attachments only if the instance count is greater than 0.
  count            = var.instance_count > 0 ? var.instance_count : 0
  # Specify the target group ARN for the attachment.
  target_group_arn = element(var.target_group_arns, count.index)
  # Assign target IDs based on instance count.
  # target_id        = var.aws_instance_ids[count.index]
  target_id        = var.aws_instance_ids[count.index % var.instance_count]
}