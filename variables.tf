variable "environment" {
  description = "The environment for which to create resources (e.g., dev, staging, prod)."
  type        = string
}

variable "project" {
  description = "The name of the project for which to create resources."
  type        = string
}

variable "vpc_tags" {
  description = "Additional tags to apply to the VPC."
  type        = map(string)
  default     = {}
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "igw_tags" {
  description = "Additional tags to apply to the Internet Gateway."
  type        = map(string)
  default     = {}
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_block" {
  description = "The CIDR block for the private subnet."
  type        = list(string)
  default     = ["10.0.11.0/24", "10.0.12.0/24"]
}

variable "database_subnet_cidr_block" {
  description = "The CIDR block for the database subnet."
  type        = list(string)
  default     = ["10.0.21.0/24", "10.0.22.0/24"]
}

variable "public_subnet_tags" {
  description = "Additional tags to apply to the public subnets."
  type        = map(string)
  default     = {}
}

variable "private_subnet_tags" {
  description = "Additional tags to apply to the private subnets."
  type        = map(string)
  default     = {}
}

variable "database_subnet_tags" {
  description = "Additional tags to apply to the database subnets."
  type        = map(string)
  default     = {}
}

variable "nat_gw_tags" {
  description = "Additional tags to apply to the NAT Gateway."
  type        = map(string)
  default     = {}
}