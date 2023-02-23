resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
      Name = "vpc-ansible"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "10.0.0.0/24"

  tags = {
      Name = "subnet-ansible"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = {
      Name = "igw-ansible"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  
  tags = {
    Name = "rt-ansible"
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rt.id
}