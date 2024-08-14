output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.project[*].id
}

output "igw_id" {
  value = aws_internet_gateway.igw[*].id
}