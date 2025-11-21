terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# Create subnets based on var.subnets (map/list)
resource "google_compute_subnetwork" "this" {
  for_each = { for s in var.subnets : s.name => s }

  name                    = each.value.name
  ip_cidr_range           = each.value.ip_cidr_range
  region                  = each.value.region
  network                 = var.network_self_link != "" ? var.network_self_link : var.network_name
  project                 = var.project_id
  private_ip_google_access = lookup(each.value, "private_ip_google_access", var.private_ip_google_access)
  description             = "Subnet ${each.value.name} for ${var.environment}"
  secondary_ip_range      = lookup(each.value, "secondary_ip_ranges", null)
  enable_flow_logs        = var.enable_flow_logs
  log_config {
    aggregation_interval = var.flowlog_aggregation_interval
    flow_sampling        = var.flowlog_flow_sampling
    metadata             = var.flowlog_metadata
  }
  depends_on = var.depends_on
}
