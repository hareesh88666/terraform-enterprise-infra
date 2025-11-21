terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# Allow internal communication within VPC
resource "google_compute_firewall" "allow_internal" {
  name    = "${var.environment}-${var.name_suffix}-allow-internal"
  network = var.network_self_link
  project = var.project_id

  allows {
    protocol = "all"
  }

  source_ranges = [var.vpc_cidr]

  description = "Allow internal traffic inside VPC"
}

# Allow SSH only from trusted IPs
resource "google_compute_firewall" "allow_ssh" {
  count   = length(var.ssh_source_ranges) > 0 ? 1 : 0
  name    = "${var.environment}-${var.name_suffix}-allow-ssh"
  network = var.network_self_link
  project = var.project_id

  allows {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = var.ssh_source_ranges

  description = "Allow SSH only from trusted IPs"
}

# Allow IAP Access
resource "google_compute_firewall" "allow_iap" {
  name    = "${var.environment}-${var.name_suffix}-allow-iap"
  network = var.network_self_link
  project = var.project_id

  allows {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["35.235.240.0/20"]

  description = "Allow IAP-based SSH and RDP access"
}

# Allow Health Checks
resource "google_compute_firewall" "allow_health_checks" {
  name    = "${var.environment}-${var.name_suffix}-allow-hc"
  network = var.network_self_link
  project = var.project_id

  allows {
    protocol = "tcp"
  }

  source_ranges = [
    "130.211.0.0/22",
    "35.191.0.0/16",
  ]

  description = "Allow Google health check traffic"
}

# Deny all other inbound traffic
resource "google_compute_firewall" "deny_all_ingress" {
  name    = "${var.environment}-${var.name_suffix}-deny-all"
  network = var.network_self_link
  project = var.project_id

  denies {
    protocol = "all"
  }

  priority      = 65535
  source_ranges = ["0.0.0.0/0"]

  description = "Deny all inbound traffic by default"
}
