# CHANGELOG

## v0.1.1 (2019-08-08)

*   Resolves incorrect repo path in taggings.tf.
    (Ref: <https://github.com/ace-teknologi/terraform-iam/issues/12>)
*   Resolves inability to change password without an MFA device activated.
    (Ref: <https://github.com/ace-teknologi/terraform-iam/issues/14>)

## v0.1.0 (2019-08-05)

*   Use of `lookup` instead of `coalesce` for taggings.
*   Follow AWS approach for IAM user policies.
    (ref: <https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_examples_aws_my-sec-creds-self-manage.html>)

## v0.0.3 (2019-08-02)

*   Self-managed SSH keys supported.

## v0.0.2 (2019-08-01)

*   Tags added!

## v0.0.1 (2019-07-29)

*   Initial release!
