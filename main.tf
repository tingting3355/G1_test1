terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

# Create a VPC
resource "aws_vpc" "g1-vpc-01" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}

# Create a Public Subnet
resource "aws_subnet" "g1-pub-sub-01" {
  vpc_id     = aws_vpc.g1-vpc-01.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "g1-pub-sub-01"
  }
}

resource "aws_subnet" "g1-pri-dev-sub-01" {
  vpc_id     = aws_vpc.g1-vpc-01.id
  cidr_block = "10.0.10.0/24"
  tags = {
    Name = "g1-pri-dev-sub-01"
  }
}

resource "aws_subnet" "g1-pri-db-sub-01" {
  vpc_id     = aws_vpc.g1-vpc-01.id
  cidr_block = "10.0.20.0/24"
  tags = {
    Name = "g1-pri-db-sub-01"
  }
}

resource "aws_subnet" "g1-pri-dev-sub-02" {
  vpc_id     = aws_vpc.g1-vpc-01.id
  cidr_block = "10.0.30.0/24"
  tags = {
    Name = "g1-pri-dev-sub-02"
  }
}


resource "aws_internet_gateway" "g1-pub-igw" {
  vpc_id = aws_vpc.g1-vpc-01.id
  tags = {
    Name = "g1-pub-igw"
  }
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

# variable "names" {
#   type    = list(string)
#   default = ["이소라", "김샛별"]
# }

# module "personal_custom_vpc" {
#   for_each = toset([for s in var.names : "${s}_test"])
#   source   = "./custom_vpc"
#   env      = "personal_${each.key}"
# }


