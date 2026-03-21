variable "region" {
  description = "The AWS region to create resources in."
  type        = string
}

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
