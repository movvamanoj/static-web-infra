resource "aws_lb_target_group" "static_web_target_group" {
  count    = var.target_group_count
  name     = "${var.target_group_names}${count.index + 1}"
  port     = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id   = var.vpc_id

  health_check {
    path                = var.health_check_path
    port                = var.health_check_port
    interval            = var.health_check_interval
    healthy_threshold   = var.health_check_healthy_threshold
    unhealthy_threshold = var.health_check_unhealthy_threshold
  }
}
#Create AWS Load Balancer Target Group Attachments (All Instances to All Target Groups)
resource "aws_lb_target_group_attachment" "instance" {
  count = var.target_instance_count * var.target_group_count
  target_group_arn = element(aws_lb_target_group.static_web_target_group.*.arn, count.index % var.target_group_count)
  target_id        = var.aws_instance_ids[count.index % var.target_instance_count]
}

