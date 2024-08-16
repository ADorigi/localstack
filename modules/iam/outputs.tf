output "role_name" {
  description = "The name of the IAM role"
  value       = aws_iam_role.role.name
}

output "role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.role.arn
}

output "policy_attachment_name" {
  description = "The name of the policy attachment"
  value       = aws_iam_policy_attachment.policy_attachment.name
}