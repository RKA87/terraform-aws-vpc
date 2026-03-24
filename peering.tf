resource "aws_vpc_peering_connection" "this" {
  count = var.create_peering ? 1 : 0

  vpc_id      = aws_vpc.main.id             #roboshop-vpc (requestor)
  peer_vpc_id = data.aws_vpc.default_vpc.id #aws default vpc (accepter)
  auto_accept = true
  # peer_owner_id = var.peer_owner_id
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
  tags = local.peering_final_tags
}

# Route from requester(roboshop vpc)  to accepter(aws default vpc) 
# - this is for default route table of roboshop vpc but i don't creating it

# resource "aws_route" "requester_to_accepter" {
#   count = var.create_peering ? 1 : 0

#   route_table_id            = aws_vpc.main.default_route_table_id
#   destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
#   vpc_peering_connection_id = "${aws_vpc_peering_connection.this[0].id}"
# }

# Route from requester(roboshop vpc) roboshop public route table to accepter(aws default vpc)
resource "aws_route" "roboshop_public_to_accepter" {
  count = var.create_peering ? 1 : 0

  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this[0].id}"
}

# Route from requester(roboshop vpc) roboshop private route table to accepter(aws default vpc)
resource "aws_route" "roboshop_private_to_accepter" {
  count = var.create_peering ? 1 : 0

  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this[0].id}"
}

# Route from requester(roboshop vpc)  roboshop database route table to accepter(aws default vpc)
resource "aws_route" "roboshop_database_to_accepter" {
  count = var.create_peering ? 1 : 0

  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this[0].id}"
}

# Route from accepter(aws default vpc) to requester(roboshop vpc)
resource "aws_route" "accepter_to_requester" {
  count = var.create_peering ? 1 : 0

  route_table_id            = data.aws_route_table.default_route_table.id
  destination_cidr_block    = aws_vpc.main.cidr_block
  vpc_peering_connection_id = "${aws_vpc_peering_connection.this[0].id}"
}