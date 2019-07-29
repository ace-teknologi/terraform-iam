data aws_caller_identity "current" {}

locals {
  authorised_account_ids = (length(var.authorised_account_ids) == 0 ?
    var.authorised_account_ids :
    [data.aws_caller_identity.current.account_id])
  authorised_account_root_arns = formatlist("arn:aws:iam::%s:root", local.authorised_account_ids)
}

# -----------------------------------------------------------------------------
# Password Policy
# -----------------------------------------------------------------------------
#
# On the surface it may not seem like this belongs in the roles module, however
# under the ACE Teknologi Security Model, only the roles module is deployed in
# all accounts. Even though some accounts may not ever contain users, it is
# still best practice to apply the password policy.

resource "aws_iam_account_password_policy" "default" {
  count = var.apply_account_password_policy ? 1 : 0

  minimum_password_length        = var.minimum_password_length
  password_reuse_prevention      = var.password_reuse_prevention
  require_lowercase_characters   = var.require_lowercase_characters
  require_numbers                = var.require_numbers
  require_uppercase_characters   = var.require_uppercase_characters
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password
  max_password_age               = var.max_password_age
}

# -----------------------------------------------------------------------------
# HUMAN ROLES
# -----------------------------------------------------------------------------
#
# Human roles require MFA to be present.
#
# * Devops
# * ReadOnly
# * Superuser
# * Support

# Master account common assume role policy
data "aws_iam_policy_document" "human_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = local.authorised_account_root_arns
    }

    condition {
      test     = "Bool"
      variable = "aws:MultiFactorAuthPresent"
      values   = ["true"]
    }
  }
}

# -----------------------------------------------------------------------------
# DevOps role
# -----------------------------------------------------------------------------

resource "aws_iam_role" "devops" {
  name               = var.devops_name
  assume_role_policy = data.aws_iam_policy_document.human_assume.json
}

resource "aws_iam_role_policy" "devops" {
  name   = var.devops_name
  role   = aws_iam_role.devops.id
  policy = data.aws_iam_policy_document.devops.json
}

data "aws_iam_policy_document" "devops" {
  statement {
    sid    = "AWSManagerRoleAllow"
    effect = "Allow"

    actions = [
      "acm:Describe*",
      "acm:Get*",
      "acm:List*",
      "acm:Request*",
      "acm:Resend*",
      "acm-pca:*",
      "autoscaling:*",
      "aws-marketplace:*",
      "config:DescribeComplianceByConfigRule",
      "config:DescribeComplianceByResource",
      "config:DescribeConfigRuleEvaluationStatus",
      "config:DescribeConfigRules",
      "config:DescribeConfigurationRecorderStatus",
      "config:DescribeConfigurationRecorders",
      "config:DescribeDeliveryChannelStatus",
      "config:DescribeDeliveryChannels",
      "config:DescribeRetentionConfigurations",
      "config:PutConfigurationRecorder",
      "config:PutDeliveryChannel",
      "config:StartConfigRulesEvaluation",
      "config:StartConfigurationRecorder",
      "config:StopConfigurationRecorder",
      "cloudformation:Describe*",
      "cloudformation:Get*",
      "cloudformation:List*",
      "cloudwatch:*",
      "dynamodb:DescribeBackup",
      "dynamodb:DescribeContinuousBackups",
      "dynamodb:DescribeGlobalTable",
      "dynamodb:DescribeGlobalTableSettings",
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:DescribeStream",
      "dynamodb:DescribeTable",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:GetShardIterator",
      "dynamodb:ListTables",
      "dynamodb:ListTagsOfResource",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:Scan",
      "dynamodb:TagResource",
      "dynamodb:UpdateItem",
      "dynamodb:UpdateTable",
      "ec2:*",
      "elasticloadbalancing:ApplySecurityGroupsToLoadBalancer",
      "elasticloadbalancing:AttachLoadBalancerToSubnets",
      "elasticloadbalancing:ConfigureHealthCheck",
      "elasticloadbalancing:CreateAppCookieStickinessPolicy",
      "elasticloadbalancing:CreateLBCookieStickinessPolicy",
      "elasticloadbalancing:CreateLoadBalancer",
      "elasticloadbalancing:CreateLoadBalancerListeners",
      "elasticloadbalancing:CreateLoadBalancerPolicy",
      "elasticloadbalancing:DeleteLoadBalancerPolicy",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:DetachLoadBalancerFromSubnets",
      "elasticloadbalancing:DisableAvailabilityZonesForLoadBalancer",
      "elasticloadbalancing:EnableAvailabilityZonesForLoadBalancer",
      "elasticloadbalancing:ModifyLoadBalancerAttributes",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RemoveTags",
      "elasticloadbalancing:SetLoadBalancerListenerSSLCertificate",
      "elasticloadbalancing:SetLoadBalancerPoliciesForBackendServer",
      "elasticloadbalancing:SetLoadBalancerPoliciesOfListener",
      "elasticbeanstalk:*",
      "events:*",
      "iam:Get*",
      "kms:CreateAlias",
      "kms:CreateKey",
      "kms:DeleteAlias",
      "kms:Describe*",
      "kms:GenerateRandom",
      "kms:Get*",
      "kms:List*",
      "kms:Encrypt",
      "kms:ReEncrypt*",
      "lambda:Create*",
      "lambda:Delete*",
      "lambda:Get*",
      "lambda:InvokeFunction",
      "lambda:List*",
      "lambda:PublishVersion",
      "lambda:Update*",
      "logs:*",
      "mediaconvert:*",
      "rds:*",
      "route53:*",
      "route53domains:*",
      "s3:CreateBucket",
      "s3:Get*",
      "s3:HeadBucket",
      "s3:List*",
      "s3:Put*",
      "s3:ReplicateObject",
      "s3:ReplicateTags",
      "s3:RestoreObject",
      "sns:*",
      "sqs:*",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "AWSManagerRoleDeny"
    effect = "Deny"

    actions = [
      "ec2:CreateDefaultSubnet",
      "ec2:CreateDefaultVpc",
      "ec2:DeleteVpc",
      "rds:DeleteDBCluster",
      "rds:DeleteDBInstance",
      "rds:DeleteDBSecurityGroup",
      "rds:DeleteDBSubnetGroup",
      "rds:StopDBCluster",
      "rds:StopDBInstance",
      "acm:DeleteCertificate",
      "acm-pca:DeleteCertificateAuthority",
      "acm-pca:RevokeCertificate",
      "elasticbeanstalk:DeleteApplication",
    ]

    resources = ["*"]
  }
}

# -----------------------------------------------------------------------------
# ReadOnly role
# -----------------------------------------------------------------------------

resource "aws_iam_role" "readonly" {
  name               = var.readonly_name
  assume_role_policy = data.aws_iam_policy_document.human_assume.json
}

resource "aws_iam_policy_attachment" "readonly" {
  name       = var.readonly_name
  roles      = [aws_iam_role.readonly.id]
  policy_arn = "arn:aws:iam::aws:policy/job-function/ViewOnlyAccess"
}

# -----------------------------------------------------------------------------
# Superuser role
# -----------------------------------------------------------------------------

resource "aws_iam_role" "superuser" {
  name               = var.superuser_name
  assume_role_policy = data.aws_iam_policy_document.human_assume.json
}

resource "aws_iam_role_policy" "superuser" {
  name   = var.superuser_name
  role   = aws_iam_role.superuser.id
  policy = data.aws_iam_policy_document.superuser.json
}

data "aws_iam_policy_document" "superuser" {
  statement {
    sid       = "Superuser"
    actions   = ["*"]
    resources = ["*"]
  }
}

# -----------------------------------------------------------------------------
# Support Role
# -----------------------------------------------------------------------------

resource "aws_iam_role" "support" {
  name               = var.support_name
  assume_role_policy = data.aws_iam_policy_document.human_assume.json
}

resource "aws_iam_policy_attachment" "support" {
  name       = var.support_name
  roles      = [aws_iam_role.support.id]
  policy_arn = "arn:aws:iam::aws:policy/job-function/SupportUser"
}

# -----------------------------------------------------------------------------
# MACHINE ROLES
# -----------------------------------------------------------------------------
#
# * Metrics

# Master account common assume role policy
data "aws_iam_policy_document" "machine_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "AWS"
      identifiers = local.authorised_account_root_arns
    }
  }
}

resource "aws_iam_role" "metrics" {
  name               = var.metrics_name
  assume_role_policy = data.aws_iam_policy_document.machine_assume.json
}

resource "aws_iam_role_policy" "metrics" {
  name   = var.metrics_name
  role   = aws_iam_role.metrics.name
  policy = data.aws_iam_policy_document.metrics.json
}

data "aws_iam_policy_document" "metrics" {
  statement {
    sid = "AllowReadingMetricsFromCloudWatch"

    actions = [
      "cloudwatch:ListMetrics",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:GetMetricData",
    ]

    resources = ["*"]
  }

  statement {
    sid = "AllowReadingTagsInstancesRegionsFromEC2"

    actions = [
      "ec2:DescribeTags",
      "ec2:DescribeInstances",
      "ec2:DescribeRegions",
    ]

    resources = ["*"]
  }
}

