output "encrypted_password" {
  value = aws_iam_user_login_profile.main.encrypted_password
}

output "key_fingerprint" {
  value = aws_iam_user_login_profile.main.key_fingerprint
}

output "name" {
  value = aws_iam_user.main.name
}
