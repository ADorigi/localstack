variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "my-vpc"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}
