# Create a VPC
resource "aws_vpc" "g1-vpc-01" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}

# Create a Public Subnet
resource "aws_subnet" "g1-pub-sub-01" {
  vpc_id            = aws_vpc.g1-vpc-01.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "g1-pub-sub-01"
  }
}

# Create a Private Subnet
resource "aws_subnet" "g1-pri-dev-sub-01" {
  vpc_id            = aws_vpc.g1-vpc-01.id
  cidr_block        = "10.0.10.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "g1-pri-dev-sub-01"
  }
}

resource "aws_subnet" "g1-pri-db-sub-01" {
  vpc_id            = aws_vpc.g1-vpc-01.id
  cidr_block        = "10.0.20.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "g1-pri-db-sub-01"
  }
}

resource "aws_subnet" "g1-pri-dev-sub-02" {
  vpc_id            = aws_vpc.g1-vpc-01.id
  cidr_block        = "10.0.30.0/24"
  availability_zone = "ap-southeast-1a"
  tags = {
    Name = "g1-pri-dev-sub-02"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "g1-pub-igw" {
  vpc_id = aws_vpc.g1-vpc-01.id
  tags = {
    Name = "g1-pub-igw"
  }
}

# Nat Gateway
resource "aws_nat_gateway" "g1-dev-nat-01" {
  connectivity_type = "private"
  # nat-gw는 private에 연결되지만 위치는 public subnet에 있어야 밖과 연결된다.
  subnet_id = aws_subnet.g1-pub-sub-01.id
  tags = {
    Name = "g1-dev-nat-01"
  }
}

# EIP g1-eip-01

resource "aws_eip" "g1-eip-01" {
  domain = "vpc"
}

# Public Route_table
resource "aws_route_table" "g1-pub-rt-01" {
  vpc_id = aws_vpc.g1-vpc-01.id
  tags = {
    Name = "g1-pub-rt-01"
  }
}

resource "aws_route" "g1-pub-igw-01" {
  route_table_id         = aws_route_table.g1-pub-rt-01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.g1-pub-igw.id
}

resource "aws_route_table_association" "route-table-association-pub-01" {
  subnet_id      = aws_subnet.g1-pub-sub-01.id
  route_table_id = aws_route_table.g1-pub-rt-01.id
}

# Private Route_table
resource "aws_route_table" "g1-pri-rt-01" {
  vpc_id = aws_vpc.g1-vpc-01.id
  tags = {
    Name = "g1-pri-rt-01"
  }
}

resource "aws_route" "g1-pri-nat-01" {
  route_table_id         = aws_route_table.g1-pri-rt-01.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.g1-dev-nat-01.id
}

resource "aws_route_table_association" "route-table-association-pri-01" {
  subnet_id      = aws_subnet.g1-pri-dev-sub-01.id
  route_table_id = aws_route_table.g1-pri-rt-01.id
}

resource "aws_route_table_association" "route-table-association-pri-02" {
  subnet_id      = aws_subnet.g1-pri-dev-sub-02.id
  route_table_id = aws_route_table.g1-pri-rt-01.id
}

resource "aws_route_table_association" "route-table-association-pri-db" {
  subnet_id      = aws_subnet.g1-pri-db-sub-01.id
  route_table_id = aws_route_table.g1-pri-rt-01.id
}


# # 개발환경
# module "default_custome_vpc" {
#   source = "./custom_vpc"
#   env    = "dev"
# }

# # 운영환경
# module "prd_custome_vpc" {
#   source = "./custom_vpc"
#   env    = "prd"
# }

# module "personal_custom_vpc" {
#   for_each = toset([for s in var.names : "${s}_test"])
#   source   = "./custom_vpc"
#   env      = "personal_${each.key}"
# }


