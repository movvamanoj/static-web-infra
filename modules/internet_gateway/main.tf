resource "aws_internet_gateway" "my_igw" {
  vpc_id = var.vpc_id

  # Define tags for the Internet Gateway.
  tags = {
    Name = var.ig_tag_name
  }
}
