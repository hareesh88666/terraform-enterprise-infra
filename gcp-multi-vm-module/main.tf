terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# Create multiple VMs from map input
resource "google_compute_instance" "vm" {
  for_each = var.vms

  name         = each.value.vm_name
  project      = var.project_id
  zone         = each.value.zone
  machine_type = each.value.machine_type

  boot_disk {
    initialize_params {
      image = data.google_compute_image.rhel.self_link
      size  = lookup(each.value, "boot_disk_size_gb", var.default_boot_size)
      type  = lookup(each.value, "boot_disk_type", var.default_boot_type)
    }
  }

  network_interface {
    subnetwork = var.subnetwork_self_link
    access_config {
      count = each.value.assign_public_ip ? 1 : 0
    }
  }

  service_account {
    email  = var.service_account_email
    scopes = var.service_account_scopes
  }

  metadata = lookup(each.value, "metadata", {})
  metadata_startup_script = lookup(each.value, "startup_script", "")

  tags   = lookup(each.value, "tags", [])
  labels = lookup(each.value, "labels", {})

  scheduling {
    preemptible       = lookup(each.value, "preemptible", false)
    automatic_restart = lookup(each.value, "automatic_restart", true)
    on_host_maintenance = lookup(each.value, "on_host_maintenance", "MIGRATE")
  }
}

data "google_compute_image" "rhel" {
  family  = "rhel-8"
  project = "rhel-cloud"
}
