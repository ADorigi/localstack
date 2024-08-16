resource "aws_iam_role" "role" {
  name               = var.role_name
  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_policy_attachment" "policy_attachment" {
  name       = "${var.role_name}-policy-attachment"
  roles      = [aws_iam_role.role.name]
  policy_arn  = var.policy_arn
}