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

  source = "./modules/ec2/vpc"

  vpc_name   = "test-vpc"
  cidr_block = "10.0.0.0/16"
  region     = "us-west-2"
}

module "subnet_1" {
  source            = "./modules/ec2/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  subnet_name       = "subnet-1"
}

module "subnet_2" {
  source            = "./modules/ec2/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  subnet_name       = "subnet-2"
}

module "subnet_3" {
  source            = "./modules/ec2/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-west-2c"
  subnet_name       = "subnet-3"
}

module "subnet_4" {
  source            = "./modules/ec2/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-west-2d"
  subnet_name       = "subnet-4"
}


module "my_iam_role" {
  source             = "./modules/iam"
  role_name          = "my-iam-role"
  assume_role_policy = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Principal": {
            "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
        }
    ]
    }
    POLICY
  policy_arn         = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

module "eks_cluster" {

  source       = "./modules/eks"
  cluster_name = "testCluster"
  role_arn     = module.my_iam_role.role_arn
  subnet_ids = [
    module.subnet_1.subnet_id,
    module.subnet_2.subnet_id,
    module.subnet_3.subnet_id,
    module.subnet_4.subnet_id
  ]

  depends_on = [
    module.subnet_1,
    module.subnet_2,
    module.subnet_3,
    module.subnet_4
  ]
}

# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eks-cluster-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Effect = "Allow"
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#         Action = "sts:AssumeRole"
#       },
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_iam_role_policy_attachment" "eks_service_policy_attachment" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
# }

# resource "aws_eks_cluster" "example" {
#   name     = "example"
#   role_arn = "arn:aws:iam::000000000000:role/eks-role"

#   vpc_config {
#     subnet_ids = ["subnet-0bb1c79de3EXAMPLE"]
#   }
# }


# module "eks_cluster" {

#   source       = "./modules/eks"
#   cluster_name = "test_cluster"
#   role_arn     = "arn:aws:iam::000000000000:role/eks-role"
#   subnet_ids = [
#     "subnet-0bb1c79de3EXAMPLE"
#   ]
# }
