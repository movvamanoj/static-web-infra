# Export the ID of the public route table.
output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public.id
}

# Export the IDs of the associations for public subnets.
output "public_route_table_association_id" {
  value = aws_route_table_association.public_subnets[*].id
}

