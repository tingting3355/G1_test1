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


