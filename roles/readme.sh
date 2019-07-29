#!/bin/bash
# This script builds a README.md file for committing to the repo

cat << README > README.md

# Terraform IAM Roles Module

This module generates generic IAM roles as follows.

## Human roles

* Devops
* Readonly
* Superuser
* Support

## Machine roles

* Metrics

## Miscellany

Since this module is recommended to be applied across all accounts, it comes
with some other goodies:-

* Password defaults

## Usage

This section of the documentation is not currently available (see
https://github.com/segmentio/terraform-docs/issues/62)
README
# terraform-docs --sort-inputs-by-required md . >> README.md
