# Terraform VPC Module
A opinionated Terraform module that helps manage Project API's and control IAM permissions authoritatively at the Project Level


Supports following:
- Authoritatively manage Project API's enabled 
- Authoritatively manage Project Level IAM Roles


## Prerequisite
This module uses docker to flatten IAM permissions passed down to module. Ensure that you have docker installed as it uses [terraform-flatten](https://hub.docker.com/r/muvaki/terraform-flatten) image to flatten the IAM Map. Information about the image can be found [here](https://github.com/muvaki/terraform-flatten)

## Usage
Example folder covers how to Manage Project enabled API's and IAM Permissions at the project level. IAM permissions are authorative and will cause confliect if you try to modify roles passed down to the module in any other form. Sample config:

```hcl
module "auto-vpc" {
    source  = "github.com/muvaki/terraform-google-project"

    services  = [
        "iam.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "clouddebugger.googleapis.com",
        "cloudtrace.googleapis.com",
        "compute.googleapis.com"
    ]

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
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | Project ID  | string. | "" | no |
| services | list of API's to enable (Authorative) | list | | yes |
| iam |  set of roles with their respective access accounts | map | {} | no |
| module_dependency | Pass an output from another variable/module to create dependency | string | "" | no |

### iam Inputs

IAM input should be passed as roles (key) with list of members as a list value. Roles can be passed as either custom role names (project/project-id/roles/role-name) or standard predefined gcp roles (roles/role-name). Members list is allowed to only have the following prefixes: domain, serviceAccount, user or group.

```hcl
    iam = {
        "roles/editor" = [
            "user:admin@muvaki.com",
            "serviceAccount:1111111111@cloudbuild.gserviceaccount.com"
        ],
        "project/muvaki/roles/superAdmin" = [
            "group:superadmins@muvaki.com"
        ]
```

## Outputs

| Name | Description | 
|------|-------------|
| result | iam flattened result |
| etag | List output of etags for each binding set per role |

## Docs:

module reference docs: 
- terraform.io (v0.11.11)
- GCP [Project](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
- GCP [IAM](https://cloud.google.com/iam/)
- Muvaki [Terraform Flatten](https://github.com/muvaki/terraform-flatten)

### LICENSE

MIT License