provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
    tags = {
    Name = "segun vpc"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.vpc1.id}"
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = "${aws_vpc.vpc1.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "private_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc1.id}"

  tags = {
    Name = "seGateWay"
  }
}


resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.vpc1.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = {
    Name = "se_routeTable"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.r.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.r.id
}
