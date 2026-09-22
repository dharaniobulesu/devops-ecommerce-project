# Public route table
# This route table will provide internet access to public subnets

resource "aws_route_table" "public" {
  # Associate the route table with our main VPC
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecommerce-public-rt"
  }
}

# Default route for internet-bound traffic
# 0.0.0.0/0 means any IPv4 destination not covered by a more specific route

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"

  # Send internet traffic through our Internet Gateway
  gateway_id = aws_internet_gateway.main.id
}

# Associate Public AZ-1 subnet with the public route table

resource "aws_route_table_association" "public_az1" {
  subnet_id      = aws_subnet.public_az1.id
  route_table_id = aws_route_table.public.id
}

# Associate Public AZ-2 subnet with the public route table

resource "aws_route_table_association" "public_az2" {
  subnet_id      = aws_subnet.public_az2.id
  route_table_id = aws_route_table.public.id
}