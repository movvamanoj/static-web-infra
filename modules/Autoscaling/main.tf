resource "aws_launch_configuration" "autoscaling_lc" {
  name        = var.launch_config_name
  image_id    = var.ec2_ami
  instance_type = var.instance_type

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier = var.public_subnet

  launch_configuration = aws_launch_configuration.autoscaling_lc.id

   tag {
    key                 = var.tag_key
    value               = var.tag_value
    propagate_at_launch = var.tag_propagate_at_launch
  }

  lifecycle {
    create_before_destroy = true
  }
}
