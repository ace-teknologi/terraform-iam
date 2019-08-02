variable "groups" {
  description = "A list of group names to add the user to"
  type        = list(string)
}

variable "public_pgp_key" {
  description = "Initial user secrets will be encrypted using this public key"
}

variable "rabbit_user" {
  description = "The rabbit user that can access this developer's vhost. Leave blank if not vhost required"
  default     = ""
}

variable "rabbit_vhost" {
  default = ""
}

variable "tags" {
  type = map(string)
}

variable "username" {
}
