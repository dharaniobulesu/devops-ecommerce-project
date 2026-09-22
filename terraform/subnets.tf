# Public subnet in Availability Zone 1
# This subnet is configured to assign public IPs to instances

resource "aws_subnet" "public_az1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecommerce-public-az1"
  }
}
# Private subnet in Availability Zone 1
# This subnet does not automatically assign public IP addresses

resource "aws_subnet" "private_az1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "ecommerce-private-az1"
  }
}
# Public subnet in Availability Zone 1
# This subnet is configured to assign public IPs to instances

resource "aws_subnet" "public_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecommerce-public-az2"
  }
}
# Private subnet in Availability Zone 2
# This subnet does not automatically assign public IP addresses

resource "aws_subnet" "private_az2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "ecommerce-private-az2"
  }
}
