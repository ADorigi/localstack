provider "aws" {
  profile = "localstack"

  endpoints {
    ec2 = "http://localhost:4566"
  }
}

locals {
  vpc_name = "vpc-terraform"
}

# module "vpc" {
#   source    = "./modules/ec2/vpc"
#   region    = "us-west-2"
#   vpc_name  = local.vpc_name
#   vpc_count = 5
#   igw_name  = "igw-terraform"
# }



module "my_iam_role" {
  source             = "./modules/iam"
  role_name          = "my-iam-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
  policy_arn         = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}