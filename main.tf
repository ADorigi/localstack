provider "aws" {
  profile = "localstack"

  endpoints {
    ec2 = "http://localhost:4566"
  }
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
  cluster_tags = {
    "_lb_ports_" = "8082"
  }

  depends_on = [
    module.subnet_1,
    module.subnet_2,
    module.subnet_3,
    module.subnet_4
  ]
}

module "eks_cluster2" {

  source       = "./modules/eks"
  cluster_name = "testCluster2"
  role_arn     = module.my_iam_role.role_arn
  subnet_ids = [
    module.subnet_1.subnet_id,
    module.subnet_2.subnet_id,
    module.subnet_3.subnet_id,
    module.subnet_4.subnet_id
  ]
  cluster_tags = {
    "_lb_ports_" = "8083"
  }

  depends_on = [
    module.subnet_1,
    module.subnet_2,
    module.subnet_3,
    module.subnet_4
  ]
}

# resource "aws_eks_cluster" "cluster2" {
#   name     = "cluster2"
#   role_arn = "arn:aws:iam::000000000000:role/eks-role"

#   vpc_config {
#     subnet_ids = ["subnet-12345678"]  
#   }
# }


# resource "aws_eks_node_group" "node_group" {
#   cluster_name    = module.eks_cluster.cluster_name
#   node_group_name = "localstack-node-group"
#   node_role_arn   = "arn:aws:iam::000000000000:role/eks-role"
#   subnet_ids         = ["subnet-0bb1c79de3EXAMPLE"]

#   scaling_config {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 1
#   }

#   depends_on = [ module.eks_cluster ]
# }

module "node_group" {

    source = "./modules/eks/nodegroup"

    cluster_name = module.eks_cluster.cluster_name
    node_group_name = "nodeGroup1"
    node_role_arn = "arn:aws:iam::000000000000:role/eks-role" 
    subnet_ids         = ["subnet-0bb1c79de3EXAMPLE"] 
    desired_size = 2
    max_size = 3
    min_size = 1
}

# resource "aws_eks_node_group" "node_group2" {
#   cluster_name    = module.eks_cluster.cluster_name
#   node_group_name = "localstack-node-group2"
#   node_role_arn   = "arn:aws:iam::000000000000:role/eks-role"
#   subnet_ids         = ["subnet-0bb1c79de3EXAMPLE"]

#   scaling_config {
#     desired_size = 2
#     max_size     = 3
#     min_size     = 1
#   }

#   depends_on = [ module.eks_cluster ]
# }