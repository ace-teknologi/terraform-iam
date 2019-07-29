output "devops_role_arn" {
  value = aws_iam_role.devops.arn
}

output "devops_role_name" {
  value = aws_iam_role.devops.name
}

output "metrics_role_arn" {
  value = aws_iam_role.metrics.arn
}

output "metrics_role_name" {
  value = aws_iam_role.metrics.name
}

output "readonly_role_arn" {
  value = aws_iam_role.readonly.arn
}

output "readonly_role_name" {
  value = aws_iam_role.readonly.name
}

output "support_role_arn" {
  value = aws_iam_role.support.arn
}

output "support_role_name" {
  value = aws_iam_role.support.name
}

output "superuser_role_arn" {
  value = aws_iam_role.superuser.arn
}

output "superuser_role_name" {
  value = aws_iam_role.superuser.name
}
