# Private route table for Availability Zone 1
# Private subnet traffic will use NAT Gateway AZ-1 for internet access.
resource "aws_route_table" "private_az1" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecommerce-private-rt-az1"
  }
}


# Private route table for Availability Zone 2
# Private subnet traffic will use NAT Gateway AZ-2 for internet access.
resource "aws_route_table" "private_az2" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecommerce-private-rt-az2"
  }
}

# Route internet-bound traffic from Private AZ-1
# through the NAT Gateway located in AZ-1.

resource "aws_route" "private_az1_internet" {
  route_table_id         = aws_route_table.private_az1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.az1.id
}


# Route internet-bound traffic from Private AZ-2
# through the NAT Gateway located in AZ-2.

resource "aws_route" "private_az2_internet" {
  route_table_id         = aws_route_table.private_az2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.az2.id
}

# Associate Private AZ-1 subnet with its private route table.
resource "aws_route_table_association" "private_az1" {
  subnet_id      = aws_subnet.private_az1.id
  route_table_id = aws_route_table.private_az1.id
}


# Associate Private AZ-2 subnet with its private route table.
resource "aws_route_table_association" "private_az2" {
  subnet_id      = aws_subnet.private_az2.id
  route_table_id = aws_route_table.private_az2.id
}