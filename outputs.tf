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

output "nat_gw_id" {
  description = "The ID of the created NAT Gateway."
  value       = aws_nat_gateway.nat.id
}

output "public_route_table_id" {
  description = "The ID of the created Route Table."
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the created Route Table."
  value       = aws_route_table.private.id
}

output "database_route_table_id" {
  description = "The ID of the created Route Table."
  value       = aws_route_table.database.id
}

# Peering Connection Outputs
output "peering_connection_id" {
  description = "The ID of the created VPC Peering Connection."
  value       = var.create_peering ? "${aws_vpc_peering_connection.this[0].id}" : ""
}