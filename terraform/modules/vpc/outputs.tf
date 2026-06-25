output "vpc_id" {
  value       = aws_vpc.main.id # Replace with the actual resource name of your VPC inside the module
  description = "The ID of the created VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id # Uses splat expression to grab all public subnet IDs in an array
  description = "List of IDs of public subnets"
}

output "private_subnet_ids" {
  value       = aws_subnet.private[*].id # Uses splat expression to grab all private subnet IDs in an array
  description = "List of IDs of private subnets"
}

