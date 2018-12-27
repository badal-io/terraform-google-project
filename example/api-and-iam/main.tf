module "project" {
    source      = "github.com/muvaki/terraform-google-project"

    project   = "${var.project-id}"
    services  = "${var.apis_to_enable}"

    iam = {
        "roles/editor" = [
            "user:admin@muvaki.com",
            "serviceAccount:1111111111@cloudbuild.gserviceaccount.com"
        ],
        "project/muvaki/roles/superAdmin" = [
            "group:superadmins@muvaki.com"
        ]
    }
}