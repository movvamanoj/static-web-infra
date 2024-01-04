resource "aws_security_group" "allow_all" {
  name        = "allow-all-traffic-308"
  description = "Allow all inbound and outbound traffic"
  vpc_id      = var.vpc_id  # Replace with your VPC ID

# Rule allowing all inbound traffic on all ports
ingress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}

# Rule allowing all outbound traffic on all ports
egress {
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}
