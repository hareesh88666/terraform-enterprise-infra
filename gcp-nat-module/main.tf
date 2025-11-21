terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# Cloud Router
resource "google_compute_router" "router" {
  name    = "${var.environment}-${var.name_suffix}-router"
  network = var.network_self_link
  region  = var.region
  project = var.project_id

  bgp {
    asn = var.bgp_asn
  }
}

# Cloud NAT
resource "google_compute_router_nat" "nat" {
  name                               = "${var.environment}-${var.name_suffix}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  project                            = var.project_id
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.subnet_nat_option

  log_config {
    enable = var.enable_nat_logs
    filter = var.nat_log_filter
  }

  dynamic "subnetwork" {
    for_each = var.subnetwork_list
    content {
      name                    = subnetwork.value.name
      source_ip_ranges_to_nat = subnetwork.value.source_ip_ranges_to_nat
    }
  }
}
