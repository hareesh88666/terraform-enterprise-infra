terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

resource "google_storage_bucket" "bucket" {
  name          = "${var.environment}-${var.name_suffix}-bucket"
  project       = var.project_id
  location      = var.location
  storage_class = var.storage_class

  uniform_bucket_level_access = var.uniform_access
  force_destroy               = var.force_destroy

  labels = var.labels

  versioning {
    enabled = var.enable_versioning
  }

  dynamic "retention_policy" {
    for_each = var.retention_period > 0 ? [1] : []
    content {
      retention_period = var.retention_period
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lookup(lifecycle_rule.value.action, "storage_class", null)
      }
      condition {
        age                   = lifecycle_rule.value.condition.age
        num_newer_versions    = lookup(lifecycle_rule.value.condition, "num_newer_versions", null)
        with_state            = lookup(lifecycle_rule.value.condition, "with_state", null)
      }
    }
  }

  encryption {
    default_kms_key_name = var.kms_key
  }

  public_access_prevention = "enforced"
}
