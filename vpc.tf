resource "aws_vpc" "sourcefuse_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sourcefuse_vpc"
  }
}

resource "aws_subnet" "sourcefuse_public_subnet_1" {
  vpc_id     = aws_vpc.sourcefuse_vpc.id
  cidr_block = "10.0.16.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "sourcefuse_public_subnet_1"
  }
}

resource "aws_subnet" "sourcefuse_public_subnet_2" {
  vpc_id     = aws_vpc.sourcefuse_vpc.id
  cidr_block = "10.0.12.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "sourcefuse_public_subnet_2"
  }
}

resource "aws_subnet" "sourcefuse_private_subnet" {
  vpc_id     = aws_vpc.sourcefuse_vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "sourcefuse_private_subnet"
  }
}

resource "aws_subnet" "sourcefuse_private_subnet2" {
  vpc_id     = aws_vpc.sourcefuse_vpc.id
  cidr_block = "10.0.4.0/24"
  tags = {
    Name = "sourcefuse_private_subnet2"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sourcefuse_vpc.id

  tags = {
    Name = "sourcefuse_igw"
  }
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.sourcefuse_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "sourcefuse_public_route_table"
  }
}
resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.sourcefuse_public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.sourcefuse_public_subnet_2.id
  route_table_id = aws_route_table.public.id
}