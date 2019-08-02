#!/bin/bash
# This script builds a README.md file for committing to the repo

cat << README > README.md

# Terraform IAM Groups Module

This module generates generic IAM roles as follows.

*   `Devops`
*   `DevopsProd`
*   `ReadOnly`
*   `ReadOnlyProd`
*   `Superuser`
*   `SuperuserProd`
*   `Support`
*   `SupportProd`
*   `UserSelfManagement`

## Usage

This section of the documentation is not currently available (see
<https://github.com/segmentio/terraform-docs/issues/62>)
README
# terraform-docs --sort-inputs-by-required md . >> README.md
