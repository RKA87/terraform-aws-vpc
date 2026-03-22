# VPC Creation

resource "aws_vpc" "main" {
  # region =  var.region
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = local.vpc_final_tags
}

#Internet Gateway Creation

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

#Subnets creation with availability zones from local variable instead of data source

resource "aws_subnet" "public"{
  count = length(var.public_subnet_cidr_block)
  vpc_id = aws_vpc.main.id
  cidr_block = "${var.public_subnet_cidr_block[count.index]}"
  availability_zone = local.az_zones[count.index]
  tags = merge(local.public_subnet_final_tags, {
    Name = "${var.project}-${var.environment}-public-subnet-${local.az_zones[count.index]}"
  })
}

resource "aws_subnet" "private"{
  count = length(var.private_subnet_cidr_block)
  vpc_id = aws_vpc.main.id
  cidr_block = "${var.private_subnet_cidr_block[count.index]}"
  availability_zone = local.az_zones[count.index]
  tags = merge(local.private_subnet_final_tags, {
    Name = "${var.project}-${var.environment}-private-subnet-${local.az_zones[count.index]}"
  })
}

resource "aws_subnet" "database"{
  count = length(var.database_subnet_cidr_block)
  vpc_id = aws_vpc.main.id
  cidr_block = "${var.database_subnet_cidr_block[count.index]}"
  availability_zone = local.az_zones[count.index]
  tags = merge(local.database_subnet_final_tags, {
    Name = "${var.project}-${var.environment}-database-subnet-${local.az_zones[count.index]}"
  })
}

# Route Table Creation
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # By default local route will be created automatically
  # Route to attach the Internet Gaway to the public subnets

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = local.public_subnet_final_tags
}

# Route Table Association for public subnets

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr_block)
  subnet_id = "${aws_subnet.public[count.index].id}"
  route_table_id = aws_route_table.public.id
}

# Route Table Creation for private
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # By default local route will be created automatically
  # Route to attach the Internet Gaway to the public subnets

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id # Private subnets will use NAT Gateway to access the Internet
  }

  tags = local.private_subnet_final_tags
}

# Route Table Association for private subnets

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr_block)
  subnet_id = "${aws_subnet.private[count.index].id}"
  route_table_id = aws_route_table.private.id
}

# Route Table Creation for database

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  # By default local route will be created automatically
  # Route to attach the Internet Gaway to the public subnets

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id # Database subnets will use the NAT gateway to access the internet for updates and patches
  }

  tags = local.database_subnet_final_tags
}

# Route Table Association for database subnets

resource "aws_route_table_association" "database" {
  count = length(var.database_subnet_cidr_block)
  subnet_id = "${aws_subnet.database[count.index].id}"
  route_table_id = aws_route_table.database.id
}

# create NAT Gateway for private subnets and database subnets in one availability zone of public subnet

resource "aws_eip" "elastic_ip" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id = "${aws_subnet.public[0].id}"

  tags = local.nat_final_tags
}