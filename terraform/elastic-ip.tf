# Elastic IP for NAT Gateway in Availability Zone 1
# This provides a static public IPv4 address for outbound internet traffic.
resource "aws_eip" "nat_az1" {
  domain = "vpc"

  tags = {
    Name = "ecommerce-nat-eip-az1"
  }
}

# Elastic IP for NAT Gateway in Availability Zone 2
# This provides a static public IPv4 address for outbound internet traffic.
resource "aws_eip" "nat_az2" {
  domain = "vpc"

  tags = {
    Name = "ecommerce-nat-eip-az2"
  }
}