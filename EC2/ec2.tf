# VPC
resource "aws_vpc" "demo_vpc" {
  cidr_block = "192.168.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"
  tags = {
    Name = "demo_vpc"
  }
}

# SUBNET
resource "aws_subnet" "demo_public_subnet" {
  vpc_id = "${aws_vpc.demo_vpc.id}"
  cidr_block = "192.168.0.0/27"
  map_public_ip_on_launch = true
  availability_zone = "us-east-2a"
  tags = {
    Name = "demo_public_subnet"
  }
}

# IGW
resource "aws_internet_gateway" "demo_igw" {
  vpc_id = "${aws_vpc.demo_vpc.id}"
  tags = {
    Name = "demo_igw"
  }
}

# ROUTE TABLE
resource "aws_route_table" "demo_rt" {
  vpc_id = "${aws_vpc.demo_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.demo_igw.id}"
  }
  tags = {
      Name = "demo_rt"
  }
}

# ROUTE TABLE ASSOCIATION
resource "aws_route_table_association" "demo_public_subnet" {
  subnet_id = "${aws_subnet.demo_public_subnet.id}"
  route_table_id = "${aws_route_table.demo_rt.id}"
}


resource "aws_security_group" "demo_sg" {
  vpc_id = "${aws_vpc.demo_vpc.id}"
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "demo_sg" 
  }
}

resource "aws_instance" "demo_ins" {
  ami = "ami-09694bfab577e90b0"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.demo_public_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.demo_sg.id}"]

  tags = {
    Name = "demo_ins"
  }
  
}
