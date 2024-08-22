resource "random_integer" "lb_port" {
  min = 49152
  max = 65535
  keepers = {
    cluster_name = var.cluster_name
  }
}

resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  tags = {
    "_lb_ports_" : random_integer.lb_port.result
  }
}