# Terraform IAM Modules

This is a collection of modules designed to provide standardised access across
AWS accounts.

## ACE Teknologi Security Model

@TODO write this up properly and blog post

> _Step 1: [lock away your root user safely](
https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)!_

Under the ACE Teknologi Security Model, users and groups are created in a
management account, while roles are created in sub-accounts that contain
infrastructure.

Users should never have permissions directly attached - instead they are added
to groups that allow them to do two things:
1. Manage their credentials
2. Assume roles so they can GSD

Roles should be created in all accounts following the principle of least
privilege, and users should use an appropriate role to carry out their tasks.

This repo contains some simple roles for some simple use cases, but generally
speaking you should create custom roles based on the least privilege needs of
staff members.

## Individal Modules

For more information, please read the readmes of the various modules:-

* [Groups](./groups)
* [Roles](./roles)
* [User](./user)
