# VPC variables
variable "region" {
  description = "The AWS region to create resources in"
  type        = string
  default     = "us-west-2"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "default-vpc"
}


variable "cidr_block" {
  description = "Network CIDR block for the vpc"
  type        = string 
}

