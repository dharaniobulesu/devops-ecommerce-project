# Internet Gateway provides internet connectivity for resources
# in subnets whose route tables point to this gateway.
resource "aws_internet_gateway" "main" {
  # Attach the Internet Gateway to our main VPC
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ecommerce-igw"
  }
}