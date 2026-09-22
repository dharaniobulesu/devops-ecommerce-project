# Security Group for the Application Load Balancer
# Allows users from the internet to access the ALB over HTTP and HTTPS.
resource "aws_security_group" "alb" {
  name        = "ecommerce-alb-sg"
  description = "Security group for Application Load Balancer"
  vpc_id      = aws_vpc.main.id

  # Allow HTTP traffic from the internet
  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow HTTPS traffic from the internet
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecommerce-alb-sg"
  }
}

# Security Group for the Application
# Only the ALB can communicate with the application.
resource "aws_security_group" "application" {
  name        = "ecommerce-app-sg"
  description = "Security group for application"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "Allow traffic from ALB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"

    # Only ALB Security Group can access
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ecommerce-app-sg"
  }
}
# Security Group for the Database
# Only the Application Security Group can access the database

resource "aws_security_group" "database" {
  name        = "ecommerce-database-sg"
  description = "Security group for database"
  vpc_id      = aws_vpc.main.id

  # Allow PostgreSQL traffic only from the Application Security Group
  ingress {
    description     = "Allow PostgreSQL from application"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.application.id]
  }
  # Allow outbound traffic
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ecommerce-database-sg"
  }
}