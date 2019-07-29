# Account IDs

variable "non_production_account_ids" {
  description = "A list of non-production accounts"
  type        = list(string)
}

variable "production_account_ids" {
  description = "A list of production accounts"
  type        = list(string)
}

# Naming

variable "devops_role_name" {
  default = "Devops"
}

variable "readonly_role_name" {
  default = "ReadOnly"
}

variable "superuser_role_name" {
  default = "Superuser"
}

variable "support_role_name" {
  default = "Support"
}

# tags

variable "tags" {
  type = map(string)
  default = {}
}
