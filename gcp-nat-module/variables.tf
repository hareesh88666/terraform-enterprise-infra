variable "project_id" {
  type        = string
  description = "GCP Project ID"
}

variable "environment" {
  type        = string
  description = "Environment (dev/qa/stage/prod)"
}

variable "name_suffix" {
  type        = string
  description = "Suffix to append to router/NAT names"
  default     = "core"
}

variable "region" {
  type        = string
  description = "Region for NAT and Cloud Router"
}

variable "network_self_link" {
  type        = string
  description = "Self-link of the VPC network"
}

variable "bgp_asn" {
  type        = number
  description = "BGP ASN for Cloud Router"
  default     = 64514
}

variable "nat_ip_allocate_option" {
  type        = string
  description = "AUTO_ONLY or MANUAL_ONLY"
  default     = "AUTO_ONLY"
}

variable "subnet_nat_option" {
  type        = string
  description = "ALL_SUBNETWORKS_ALL_IP_RANGES or LIST_OF_SUBNETWORKS"
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "subnetwork_list" {
  type = list(object({
    name                    = string
    source_ip_ranges_to_nat = list(string)
  }))
  description = "List of subnetworks for NAT (if using LIST_OF_SUBNETWORKS)"
  default     = []
}

variable "enable_nat_logs" {
  type        = bool
  description = "Enable NAT logs"
  default     = true
}

variable "nat_log_filter" {
  type        = string
  description = "Filter for NAT logs (ALL, ERRORS_ONLY, TRANSLATIONS_ONLY)"
  default     = "ALL"
}
