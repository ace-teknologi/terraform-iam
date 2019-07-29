output "devops_group_name" {
  value = aws_iam_group.devops.name
}

output "devops_prod_group_name" {
  value = aws_iam_group.devops_prod.name
}

output "readonly_group_name" {
  value = aws_iam_group.readonly.name
}

output "readonly_prod_group_name" {
  value = aws_iam_group.readonly_prod.name
}

output "superuser_group_name" {
  value = aws_iam_group.superuser.name
}

output "superuser_prod_group_name" {
  value = aws_iam_group.superuser_prod.name
}

output "support_group_name" {
  value = aws_iam_group.support.name
}

output "support_prod_group_name" {
  value = aws_iam_group.support_prod.name
}

output "self_management_group_name" {
  value = aws_iam_group.self_management.name
}
