terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# Compute instance
resource "google_compute_instance" "this" {
  name         = "${var.environment}-${var.name_suffix}-${var.instance_name}"
  project      = var.project_id
  zone         = var.zone
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = var.image_project != "" && var.image_family != "" ? data.google_compute_image.selected.self_link : var.custom_image
      size  = var.boot_disk_size_gb
      type  = var.boot_disk_type
    }
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
    access_config {
      # Only create access_config when assign_public_ip is true
      count = var.assign_public_ip ? 1 : 0
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  metadata = var.metadata

  metadata_startup_script = var.startup_script

  tags = var.tags
  labels = var.labels

  scheduling {
    preemptible       = var.preemptible
    automatic_restart = var.automatic_restart
    on_host_maintenance = var.on_host_maintenance
  }

  depends_on = var.depends_on
}

data "google_compute_image" "selected" {
  count = var.image_project != "" && var.image_family != "" ? 1 : 0
  family  = var.image_family
  project = var.image_project
}
