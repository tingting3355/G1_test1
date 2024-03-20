terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
  required_version = ">=1.7.1"
}

# Configure the AWS Provider
provider "aws" {
  region = var.region
}


module "g1-inf-vpc-01" {
  source = "./custom_vpc"
}

module "bastion-ec2" {
  source    = "./instance"
  subnet_id = module.g1-inf-vpc-01.pub_sub_01_id
}

module "pub-01-ec2" {
  source    = "./instance"
  subnet_id = module.g1-inf-vpc-01.pub_sub_01_id
}

module "pri-01-ec2" {
  count     = 3
  source    = "./instance"
  subnet_id = module.g1-inf-vpc-01.pri_dev_sub_01_id
}

module "pri-02-ec2" {
  count     = 3
  source    = "./instance"
  subnet_id = module.g1-inf-vpc-01.pri_dev_sub_02_id
}
