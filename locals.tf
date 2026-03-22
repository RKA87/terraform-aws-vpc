locals {
  common_tags = {
    Environment = var.environment
    Project     = var.project
    Deployment  = "terraform"
  }

  vpc_final_tags = merge(local.common_tags, var.vpc_tags,
    {
      Name = "${var.project}-${var.environment}-vpc"
    }
  )

  igw_final_tags = merge(local.common_tags, var.igw_tags,
    {
      Name = "${var.project}-${var.environment}-igw"
    }
  )

  public_subnet_final_tags = merge(local.common_tags, var.public_subnet_tags)

  private_subnet_final_tags = merge(local.common_tags, var.private_subnet_tags)

  database_subnet_final_tags = merge(local.common_tags, var.database_subnet_tags)

  az_zones = slice(data.aws_availability_zones.all_available_zones.names, 0,2)

}
