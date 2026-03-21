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
}
