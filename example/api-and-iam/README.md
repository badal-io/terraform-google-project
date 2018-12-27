# Enable managment of Project API and IAM

Following example shows how you can manage GCP Project API's and IAM Permissions. Both settings are authorative so they will cause conflict if you use non-authorative iam binding or use a service whose api is not managed by this module.

example for variable **apis_to_enable**
```hcl
    apis_to_enable  = [
        "iam.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "clouddebugger.googleapis.com",
        "cloudtrace.googleapis.com",
        "compute.googleapis.com"
    ]
```