variable "subnet_name" {
    description = "Name of the subnet"
    type = string
}

variable "cidr_block" {
    description = "CIDR block for the subnet"
    type = string
}

variable "availability_zone" {
    description = "Availability zone for the subnet"
    type = string
}

variable "vpc_id" {
    description = "VPC ID in for this subnet"
    type = string
}
