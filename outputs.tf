output "result" {
  value = "${data.external.flatten.result["output"]}"
}

output "etag" {
  value = "${google_project_iam_binding.default.*.etag}"
}