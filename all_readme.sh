#!/bin/bash
# Update all the readmes!

set -euo pipefail

# Check the current tag
echo "Generating docs for the git tag $(git describe --tags)"

# Check for terraform-docs
TD_VERSION="$(terraform-docs --version)"
echo "You're running terraform-docs $TD_VERSION"

function generate_readme {
  echo "Updating $1"
  cd $1
  terraform0.12 init > /dev/null
  AWS_REGION=ap-southeast-2 terraform0.12 validate
  ./readme.sh
  cd ..
}

generate_readme groups
generate_readme roles
generate_readme user
