# Define a route table for public subnets.
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id
  tags = {
    Name = var.public_route_table_tag_name
  }
}
# Define a default route for public subnets to the internet gateway.
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.gateway_id
    
  }
# Associate the public route table with public subnets.
  resource "aws_route_table_association" "public_subnets" {
    count            = var.public_subnet_cidrs_count > 0 ? var.public_subnet_cidrs_count : 0
    subnet_id = var.public_subnet[0] // static reference
    route_table_id = aws_route_table.public.id
  }
