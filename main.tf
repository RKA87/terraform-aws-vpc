resource "aws_vpc" "main" {
  # region =  var.region
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
#   cidr_block = "${var.public_subnet_cidr_block[count.index]}"
#   availability_zone = data.aws_availability_zones.all_available_zones.names[count.index]
#   tags = merge(local.public_subnet_final_tags, {
#     Name = "${var.project}-${var.environment}-public-subnet-${count.index}"
#   })
# }

# resource "aws_subnet" "private" {
#   count = length(var.private_subnet_cidr_block)
#   vpc_id = aws_vpc.main.id
#   cidr_block = "${var.private_subnet_cidr_block[count.index]}"
#   availability_zone = data.aws_availability_zones.all_available_zones.names[count.index +2]
#   tags = merge (local.private_subnet_final_tags, {
#     Name = "${var.project}-${var.environment}-private-subnet-${count.index}"
#   })
# }

# resource "aws_subnet" "database" {
#   count = length(var.database_subnet_cidr_block)
#   vpc_id = aws_vpc.main.id
#   cidr_block = "${var.database_subnet_cidr_block[count.index]}"
#   availability_zone = data.aws_availability_zones.all_available_zones.names[count.index +4]
#   tags = merge(local.database_subnet_final_tags, {
#     Name = "${var.project}-${var.environment}-database-subnet-${count.index}"
#   })
# }

resource "aws_subnet" "public"{
  count = length(var.public_subnet_cidr_block)
  vpc_id = aws_vpc.main.id
  cidr_block = "${var.public_subnet_cidr_block[count.index]}"
  availability_zone = "${local.az_zones[count.index]}"
  tags = merge(local.public_subnet_final_tags, {
    Name = "${var.project}-${var.environment}-public-subnet-${count.index}"
  })
}