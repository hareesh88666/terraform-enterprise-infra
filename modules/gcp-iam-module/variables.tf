variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "environment" {
  type        = string
  description = "Environment name (dev/qa/stage/prod)"
}

variable "service_accounts" {
  type = list(object({
    name           = string
    display_name   = string
    project_roles  = list(string)
    sa_roles       = list(string)
  }))
  description = "List of service accounts to create and roles to assign"
  default     = []
}
