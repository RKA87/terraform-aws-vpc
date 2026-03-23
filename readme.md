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

- environment (Required) variable in a string type like Dev, UAT, Test, Prod
- project (Required) variable in a string type about the project
- Following variables are optional
  - vpc_cidr_block variable in list(string) type
  - vpc_tags variable in map(string) type
  - igw_tags variable in map(string) type
  - public_subnet_cidr_block variable in list(string) type
  - private_subnet_cidr_block variable in list(string) type
  - database_subnet_cidr_block variable in list(string) type
  - public_subnet_tags variable in map(string) type
  - private_subnet_tags variable in map(string) type
  - database_subnet_tags variable in map(string) type

# Outputs
- vpc_id - The ID of the VPC
- igw_id - The ID of Internet Gateway
- availabilityzones - AZ Info
- public_subnet_ids - Public Subent ID's
- private_subnet_ids - Private Subent ID's
- database_subnet_ids - Database Subent ID's
- nat_gw_id - ID of NAT Gateway
- public_route_table_id - Public Route Table ID
- private_route_table_id - Private Route Table ID
- database_route_table_id - Database Route Table ID