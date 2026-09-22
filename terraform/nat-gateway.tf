# NAT Gateway for Availability Zone 1
# Placed in the public subnet so private resources can reach the internet.

resource "aws_nat_gateway" "az1" {
  allocation_id = aws_eip.nat_az1.id       //Attach the Elastic IP we just created to this NAT Gateway.
  subnet_id     = aws_subnet.public_az1.id //NAT Gateway inside the public subnet.

  tags = {
    Name = "ecommerce-nat-az1"
  }

  depends_on = [aws_internet_gateway.main]
}

# NAT Gateway for Availability Zone 2
# Placed in the public subnet so private resources can reach the internet.

resource "aws_nat_gateway" "az2" {
  allocation_id = aws_eip.nat_az2.id
  subnet_id     = aws_subnet.public_az2.id

  tags = {
    Name = "ecommerce-nat-az2"
  }

  depends_on = [aws_internet_gateway.main]
}