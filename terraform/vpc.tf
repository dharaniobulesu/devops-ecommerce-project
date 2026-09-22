resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16" // Gives us a large private address space that we can divide into multiple subnets later
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "ecommerce -vpc"
  }
}