resource "aws_iam_user" "main" {
  name          = var.username
  force_destroy = true
  tags          = local.tags
}

resource "aws_iam_user_login_profile" "main" {
  user    = aws_iam_user.main.name
  pgp_key = var.public_pgp_key
}

resource "aws_iam_user_group_membership" "main" {
  user   = aws_iam_user.main.name
  groups = var.groups
}
