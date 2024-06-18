resource "aws_vpc" "simanis-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_internet_gateway" "simanis-igw" {
  vpc_id = aws_vpc.simanis-vpc.id
  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_subnet" "simanis-subnet-public" {
  count             = var.public_sn_count
  vpc_id            = aws_vpc.simanis-vpc.id
  cidr_block        = var.public_cidrs[count.index]
  availability_zone = var.avaibility_zone[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch
  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_default_route_table" "simanis-rt-default" {
  default_route_table_id = aws_vpc.simanis-vpc.default_route_table_id
  route {
    cidr_block = var.rt_route_cidr_block
    gateway_id = aws_internet_gateway.simanis-igw.id
  }
  tags = {
    Name = var.tags["Name"]
    Env = var.tags["Env"]
  }
}

resource "aws_route_table_association" "simanis-rta" {
  count = var.public_sn_count
  subnet_id      = aws_subnet.simanis-subnet-public[count.index].id
  route_table_id = aws_default_route_table.simanis-rt-default.id
}
