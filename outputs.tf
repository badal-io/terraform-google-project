output "etag" {
  value = "${google_project_iam_binding.default.*.etag}"
}