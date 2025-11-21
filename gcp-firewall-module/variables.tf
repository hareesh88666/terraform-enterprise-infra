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
  description = "Service/project name suffix"
  default     = "core"
}

variable "network_self_link" {
  type        = string
  description = "Self-link of the VPC network"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block of VPC for internal allow rule"
}

variable "ssh_source_ranges" {
  type        = list(string)
  description = "Allowed IPs for SSH access"
  default     = []
}
