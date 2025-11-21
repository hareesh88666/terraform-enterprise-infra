variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name_suffix" {
  type        = string
  default     = "core"
}

variable "location" {
  type        = string
  description = "Bucket location"
  default     = "ASIA-SOUTH1"
}

variable "storage_class" {
  type        = string
  default     = "STANDARD"
}

variable "uniform_access" {
  type        = bool
  default     = true
}

variable "force_destroy" {
  type        = bool
  default     = false
}

variable "enable_versioning" {
  type        = bool
  default     = false
}

variable "retention_period" {
  type        = number
  default     = 0
}

variable "kms_key" {
  type        = string
  default     = ""
}

variable "labels" {
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  type = list(object({
    action = object({
      type          = string
      storage_class = optional(string)
    })
    condition = object({
      age                = number
      num_newer_versions = optional(number)
      with_state         = optional(string)
    })
  }))
  default = []
}
