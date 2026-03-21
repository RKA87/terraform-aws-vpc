resource "aws_vpc" "main" {
  region =  var.region
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true


  tags = local.vpc_final_tags
}