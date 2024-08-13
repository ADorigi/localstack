provider "aws" {
  profile = "localstack"

  endpoints {
        ec2 = "http://localhost:4566"
      }
}


module "vpc" {
  source              = "./modules/vpc"
  region              = "us-west-2"
  vpc_name            = "my-vpc"
  vpc_cidr            = "10.0.0.0/16"
}