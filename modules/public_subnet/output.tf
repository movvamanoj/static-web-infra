output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}
# Export the names of the availability zones.
output "subnet_availability_zones" {
  value = data.aws_availability_zones.available.names
}
