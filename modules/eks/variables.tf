variable "cluster_name" {
  description = "The name of the EKS cluster."
  type        = string
}

variable "role_arn" {
  description = "The ARN of the IAM role that provides permissions for the EKS cluster."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the EKS cluster."
  type        = list(string)
}

variable "cluster_tags" {
  description = "A map of tags to assign to the EKS cluster"
  type        = map(string)
}