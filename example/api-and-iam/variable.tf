variable "project_id" {
  description = "The project id for where the VPC will reside"
  type        = "string"
}

variable "apis_to_enable" {
  description = "List of apis to enable"
  type        = "list"
}