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

# resource "aws_subnet" "public" {
#   count = length(var.public_subnet_cidr_block)
#   vpc_id = aws_vpc.main.id
#   cidr_block = ${var.public_subnet_cidr_block[count.index]}
#   availability_zone = var.availability_zone

#   tags = local.route_table_final_tags
# }