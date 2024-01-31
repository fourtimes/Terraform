# creation for VPC
resource "aws_vpc" "prod_vpc" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
  instance_tenancy     = "default"

  tags = {
    Name = "prod-vpc"
  }
}

#  creation for Public Subnet
resource "aws_subnet" "prod_public_subnet" {
  vpc_id = "${aws_vpc.prod_vpc.id}"
  cidr_block = "192.168.0.0/27"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1a"

  tags = {
    Name = "prod_public_subnet"
  }
}

# creation for IGW
resource "aws_internet_gateway" "prod_igw" {
  vpc_id = "${aws_vpc.prod_vpc.id}"

  tags = {
    Name= "prod_igw"
  }
}

# Creation for Route Table
resource "aws_route_table" "prod_public_rt" {
  vpc_id = "${aws_vpc.prod_vpc.id}"
  
  # configure IGW to Route Table
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.prod_igw.id}"
  }

  tags = {
    Name = "prod_public_rt"
  }
}

# Associate Public Subnet to Route Table
resource "aws_route_table_association" "prod_public_subnet" {
  subnet_id = "${aws_subnet.prod_public_subnet.id}"
  route_table_id = "${aws_route_table.prod_public_rt.id}"
}