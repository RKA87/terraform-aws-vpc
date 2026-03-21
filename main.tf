resource "aws_vpc" "main" {
  region =  var.region
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = local.igw_final_tags
}