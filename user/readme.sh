#!/bin/bash
# This script builds a README.md file for committing to the repo

cat << README > README.md

# Terraform IAM Roles Module

This module generates a single user, and adds them to appropriate groups.

# Usage instructions:

1.  Generate a PGP key

    ### Option A

    Use keybase.io. You can just feed your keybase.io username in to this module
    and we'll do the rest.

    ### Option B

    [Find some supported software for your platform](https://gnupg.org/download/)

2.  Use this module to create your user

    \`\`\`
    module "stuart" {
      source = "git@github.com:aceteknologi/terraform-iam.git//user?ref=v0.0.1"

      username = "stuart@aceteknologi.com"

      # if you used keybase.io this could be
      # public_pgp_key = "keybase:<username>"

      # or it could be something long-winded, like
      # public_pgp_key = "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"

      # Maximum 10 groups!
      groups = [
        "\${module.groups.self_management_group_name}",
        "\${module.groups.devops_group_name}",
        "\${module.groups.devops_prod_group_name}",
        "\${module.groups.superuser_group_name}",
        "\${module.groups.superuser_prod_group_name}",
      ]

      tags = "\${local.tags}"
    }

    output "stuart" {
      value = <<EOF
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Initial login details for \${module.stuart.name}

    Password: \${module.stuart.encrypted_password}

    Please decrypt this password with the PGP key with the fingerprint \${module.stuart.key_fingerprint}
    Hint: \`echo "\${module.stuart.encrypted_password}" | base64 --decode | gpg\`
    OR
    \`echo "\${module.stuart.encrypted_password}" | base64 --decode | keybase pgp decrypt\`
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    EOF
    }
    \`\`\`

3.  Decode the output

    \`echo "wcFMA/........." | base64 --decode | gpg\`

4.  Login to the [console!](https://console.aws.amazon.com/)

    -   Enter your account ID
    -   Enter your username
    -   Enter your decrypted password

5.  Navigate to IAM » <Your User> » Security credentials

6.  Next to "Assigned MFA device", hit the "Manage" link and create yourself an
    MFA device

7.  Sign out

8.  Sign in (this time with MFA!)

9.  Navigate back to IAM » <Your User> » Security credentials

10. Hit the create access key button! You now have keys. Rotate them often.

## Usage

This section of the documentation is not currently available (see
https://github.com/segmentio/terraform-docs/issues/62)
README
# terraform-docs --sort-inputs-by-required md . >> README.md
