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
  depends_on        = [aws_vpc.main_vpc]

  tags = {
    Name        = "${var.prefix}-subnet-public-a-${var.environment}"
    Environment = var.environment
  }

}

resource "aws_subnet" "subnet_public_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "${var.aws_region}b"
  depends_on        = [aws_vpc.main_vpc]

  tags = {
    Name        = "${var.prefix}-subnet-public-b-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "subnet_private_a" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "${var.aws_region}a"
  depends_on        = [aws_vpc.main_vpc]

  tags = {
    Name        = "${var.prefix}-subnet-private-a-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_subnet" "subnet_private_b" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "${var.aws_region}b"
  depends_on        = [aws_vpc.main_vpc]

  tags = {
    Name        = "${var.prefix}-subnet-private-b-${var.environment}"
    Environment = var.environment
  }
}





resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.main_vpc.id
  depends_on = [aws_vpc.main_vpc]

  tags = {
    Name        = "${var.prefix}-igw-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name        = "${var.prefix}-ngw-eip-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.subnet_public_a.id

  tags = {
    Name        = "${var.prefix}-ngw-${var.environment}"
    Environment = var.environment
  }
}



resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "${var.prefix}-rt-public-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "public_rta_a" {
  subnet_id      = aws_subnet.subnet_public_a.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta_b" {
  subnet_id      = aws_subnet.subnet_public_b.id
  route_table_id = aws_route_table.public_rt.id
}



resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name        = "${var.prefix}-rt-private-${var.environment}"
    Environment = var.environment
  }
}

resource "aws_route_table_association" "private_rta_a" {
  subnet_id      = aws_subnet.subnet_private_a.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rta_b" {
  subnet_id      = aws_subnet.subnet_private_b.id
  route_table_id = aws_route_table.private_rt.id
}
