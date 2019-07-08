// Provides information on GCP provider config
data "google_client_config" "default" {}

# Locals variables : Module logic
locals {
  iam_permissions = [
    for k, v in var.iam:
    { "role" = k, "members" = v}
  ]
}


# # Allows management of existing projects API (Authorative)
resource "google_project_services" "default" {
  project   = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
  services  = "${var.services}"
}

# Project Level iam role Binding Policy - Authoritative for given role
resource "google_project_iam_binding" "default" {
    count     = "${length(local.iam_permissions) > 0 ? length(local.iam_permissions) : 0}"

    project   = "${length(var.project) > 0 ? var.project : data.google_client_config.default.project}"
    role      = "${trimspace(local.iam_permissions[count.index].role)}"

    members   = "${compact(local.iam_permissions[count.index].members)}"

    depends_on = ["google_project_services.default"]
}