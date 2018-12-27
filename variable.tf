variable "module_dependency" {
  type        = "string"
  default     = ""
  description = "This is a dummy value to great module dependency"
}

variable "project" {
    description = "The project in which the resource belongs. If it is not provided, the provider project is used."
    type        = "string"
    default     = ""
}

variable "services" {
    description = "List of project services to enable"
    type        = "list"
}

variable "iam" {
    description = "List of role and members to set permissions for in project"
    type        = "map"
    default     = {}
}