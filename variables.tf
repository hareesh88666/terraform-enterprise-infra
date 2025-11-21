variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "environment" {
  type        = string
  description = "Environment (dev/qa/stage/prod)"
}

variable "name_suffix" {
  type        = string
  description = "Project/service suffix"
  default     = "core"
}

variable "routing_mode" {
  type        = string
  description = "GCP routing mode"
  default     = "REGIONAL"
}
