output "ec2_instance_ids" {
  value = [for instance in aws_instance.ec2_instance : instance.id]
}
