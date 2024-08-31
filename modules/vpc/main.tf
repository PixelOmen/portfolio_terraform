resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.prefix}-vpc-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "subnet_public_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.prefix}-subnet-public-a-${var.environment}"
    Environment = var.environment
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "subnet_private_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}a"

  tags = {
    Name        = "${var.prefix}-subnet-private-a-${var.environment}"
    Environment = var.environment
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "subnet_public_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.prefix}-subnet-public-b-${var.environment}"
    Environment = var.environment
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_subnet" "subnet_private_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.aws_region}b"

  tags = {
    Name        = "${var.prefix}-subnet-private-b-${var.environment}"
    Environment = var.environment
  }

  depends_on = [aws_vpc.main_vpc]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name        = "${var.prefix}-igw-${var.environment}"
    Environment = var.environment
  }
}


