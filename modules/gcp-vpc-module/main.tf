terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

resource "google_compute_network" "vpc" {
  name                    = "${var.environment}-${var.name_suffix}-vpc"
  auto_create_subnetworks = false
  routing_mode            = var.routing_mode
  project                 = var.project_id
  description             = "Enterprise VPC for ${var.environment}"
}
