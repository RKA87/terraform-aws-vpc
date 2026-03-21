output "vpc_id" {
  description = "The ID of the created VPC."
  value       = aws_vpc.main.id
}

output "availability_zones" {
  value = data.aws_availability_zones.all_vailable_zones.names
  }
