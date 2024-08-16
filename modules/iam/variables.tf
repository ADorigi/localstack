variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "The assume role policy document"
  type        = string
}

variable "policy_arn" {
  description = "The ARN of the policy to attach"
  type        = string
}