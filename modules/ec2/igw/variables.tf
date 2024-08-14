# IGW variables

variable "igw_name" {
  description = "The name of the Internet Gateway"
  type        = string
  default     = "default-igw"
}

variable "vpc_id" {
  description = "ID of the vpc for this Internet Gateway"
  type        = string
}