// Provides information on GCP provider config
data "google_client_config" "default" {}

# Flattens IAM Permissions for consumption via google_storage_bucket_iam_binding
data "external" "flatten" {
  program = ["docker", "run", "muvaki/terraform-flatten:0.1.0", "iam", "${jsonencode(var.iam)}"]
}

# Locals variables : Module logic
locals {
  iam_permissions = "${compact(split(",", data.external.flatten.result["iam"]))}"
}

# Allows management of existing projects API (Authorative)
resource "google_project_services" "default" {
  project   = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
  services  = "${var.services}"
}

# Project Level iam role Binding Policy - Authoritative for given role
resource "google_project_iam_binding" "default" {
    count     = "${length(local.iam_permissions) > 0 ? length(local.iam_permissions) : 0}"

    project   = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    role      = "${trimspace(element(split("|", local.iam_permissions[count.index]), 0))}"

    members   = [
      "${compact(split(" ", element(split("|", local.iam_permissions[count.index]), 1)))}"
    ]

    depends_on = ["google_project_services.default"]
}