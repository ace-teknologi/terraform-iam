locals {
  tf_module      = "user"
  tf_module_repo = "github.com/aceteknologi/terraform-iam"
  tf_root_path   = coalesce(var.tags["tf_path"], "unknown")
}

locals {
  tags = merge(
    var.tags,
    {
      "tf_module"      = local.tf_module
      "tf_module_repo" = local.tf_module_repo
      "tf_path"        = "${local.tf_root_path}.${local.tf_module}"
    },
  )
}
