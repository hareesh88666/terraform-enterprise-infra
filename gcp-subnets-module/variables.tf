variable "project_id" {
  type        = string
  description = "GCP project ID"
}

variable "environment" {
  type        = string
  description = "Environment (dev/qa/stage/prod)"
  default     = "dev"
}

variable "network_self_link" {
  type        = string
  description = "Self-link of the VPC network (preferred)"
  default     = ""
}

variable "network_name" {
  type        = string
  description = "Name of the VPC network (used if network_self_link is empty)"
  default     = ""
}

variable "subnets" {
  type = list(object({
    name                  = string
    region                = string
    ip_cidr_range         = string
    private_ip_google_access = optional(bool)
    secondary_ip_ranges   = optional(list(object({range_name=string, ip_cidr_range=string})))
  }))
  description = "List of subnet definitions. Each item requires name, region and ip_cidr_range."
  default     = []
}

variable "private_ip_google_access" {
  type        = bool
  description = "Enable Private Google Access on subnets by default"
  default     = false
}

variable "enable_flow_logs" {
  type        = bool
  description = "Enable VPC Flow Logs on the subnets"
  default     = false
}

variable "flowlog_aggregation_interval" {
  type        = string
  description = "Aggregation interval for flow logs: COLLECTION_INTERVAL_UNSPECIFIED | INTERVAL_5_SEC | INTERVAL_10_MIN"
  default     = "INTERVAL_10_MIN"
}

variable "flowlog_flow_sampling" {
  type        = number
  description = "Flow sampling rate between 0 and 1"
  default     = 0.5
}

variable "flowlog_metadata" {
  type        = string
  description = "Flow log metadata options: INCLUDE_ALL_METADATA | EXCLUDE_METADATA"
  default     = "INCLUDE_ALL_METADATA"
}

variable "depends_on" {
  type        = list(any)
  description = "Optional list of dependencies for creation ordering"
  default     = []
}
