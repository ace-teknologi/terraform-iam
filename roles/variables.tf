variable "allow_users_to_change_password" {
  description = "Whether to allow users to change their own password."
  default     = true
}

variable "apply_account_password_policy" {
  description = "Whether to apply to account password policy that is included with this module."
  default     = true
}

variable "devops_name" {
  description = "A name for the Devops role"
  default     = "Devops"
}

variable "authorised_account_ids" {
  description = "The ids of accounts that are authorised to assume roles the roles created by this module. If none are specified, the calling account will be given access."
  type        = list(string)
  default     = []
}

variable "max_password_age" {
  description = "In days."
  default     = 90
}

variable "metrics_name" {
  description = "A name for the metrics role"
  default     = "Metrics"
}

variable "minimum_password_length" {
  default = 14
}

variable "password_reuse_prevention" {
  description = "The number of times you'll have to cycle a password before reuse"
  default     = 24
}

variable "readonly_name" {
  description = "A name for the readonly role"
  default     = "ReadOnly"
}

variable "require_lowercase_characters" {
  description = "Whether to require lowercase characters for user passwords."
  default     = true
}

variable "require_numbers" {
  description = "Whether to require numbers for user passwords."
  default     = true
}

variable "require_uppercase_characters" {
  description = "Whether to require uppercase characters for user passwords."
  default     = true
}

variable "require_symbols" {
  description = "Whether to require symbols for user passwords."
  default     = true
}

variable "superuser_name" {
  description = "A name for the superuser role"
  default     = "Superuser"
}

variable "support_name" {
  description = "A name for the support role"
  default     = "Support"
}

variable "tags" {
  type    = map(string)
  default = {}
}

