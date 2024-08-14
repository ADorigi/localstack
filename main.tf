provider "aws" {
  profile = "localstack"

  endpoints {
    ec2 = "http://localhost:4566"
  }
}

locals {
  vpc_name = "vpc-terraform"
}

module "vpc" {
  source    = "./modules/ec2/vpc"
  region    = "us-west-2"
  vpc_name  = local.vpc_name
  vpc_count = 5
  igw_name  = "igw-terraform"
}

