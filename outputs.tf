output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.main.id
}

output "igw_id" {
  description = "The ID of the created Internet Gateway."
  value       = aws_internet_gateway.main.id
}

output "availability_zones" {
  value = data.aws_availability_zones.all_available_zones.names
  }

output "public_subnet_ids" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets."
  value       = aws_subnet.private[*].id
}

output "database_subnet_ids" {
  description = "The IDs of the database subnets."
  value       = aws_subnet.database[*].id
}
