# Description

A Terraform Moudle to create a new 
- VPC with public, Private and Database Subnets 
- NAT Gateway for Private Subnets egress traffic 
- Internet Gateway for Public Subnets
- Route Table (Routes) for Public, Private and Database Subnets

## Usage

```hcl
module "roboshop_vpc" {
  source = "git::https://github.com/RKA87/terraform-aws-vpc?ref=main"
  environment = var.environment
  project = var.project
  vpc_tags = var.vpc_tags
  igw_tags = var.igw_tags
  public_subnet_tags = var.pub_subnet_tags
  private_subnet_tags = var.pvt_subnet_tags
  database_subnet_tags = var.db_subnet_tags
  nat_gw_tags = var.nat_gateway_tags
}
```

# Features

- VPC with configurable CIDR block and DNS hostname support
- Public, private, and database subnet tiers across multiple Availability Zones
- Internet Gateway for public subnets
- NAT Gateway (with Elastic IP) for private and database subnet outbound access
- Separate route tables for each subnet tier
- Optional VPC peering support flag
- Fully customizable tags on every resource

# Inputs
These are variable inputs to pass-on during deployment

| Name | Type | Required | Description |
|:-----|:-----|:--------:|:------------|
| environment | string | Yes | Environment name like Dev, UAT, Test, Prod |
| project | string | Yes | Project name |
| vpc_cidr_block | list(string) | Optional | VPC CIDR block |
| vpc_tags | map(string) | Optional | Tags for VPC |
| igw_tags | map(string) | Optional | Tags for Internet Gateway |
| public_subnet_cidr_block | list(string) | Optional | Public subnet CIDR blocks |
| private_subnet_cidr_block | list(string) | Optional | Private subnet CIDR blocks |
| database_subnet_cidr_block | list(string) | Optional | Database subnet CIDR blocks |
| public_subnet_tags | map(string) | Optional | Tags for public subnets |
| private_subnet_tags | map(string) | Optional | Tags for private subnets |
| database_subnet_tags | map(string) | Optional | Tags for database subnets |

# Outputs

| Name | Description |
|:-----|:------------|
| vpc_id | The ID of the VPC |
| igw_id | The ID of Internet Gateway |
| availabilityzones | AZ Info |
| public_subnet_ids | Public Subnet ID's |
| private_subnet_ids | Private Subnet ID's |
| database_subnet_ids | Database Subnet ID's |
| nat_gw_id | ID of NAT Gateway |
| public_route_table_id | Public Route Table ID |
| private_route_table_id | Private Route Table ID |
| database_route_table_id | Database Route Table ID |