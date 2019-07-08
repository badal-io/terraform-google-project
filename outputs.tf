output "etag" {
  value = "${google_project_iam_binding.default.*.etag}"
}

output "project-id" {
  value = "${google_project_services.default.project}"
}