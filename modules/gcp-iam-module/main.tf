terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.0"
    }
  }
}

# 1️⃣ Create Service Accounts
resource "google_service_account" "service_accounts" {
  for_each = { for sa in var.service_accounts : sa.name => sa }

  account_id   = "${var.environment}-${each.value.name}"
  display_name = each.value.display_name
  project      = var.project_id
}

# 2️⃣ Assign PROJECT-LEVEL IAM Roles
resource "google_project_iam_member" "project_roles" {
  for_each = {
    for sa in var.service_accounts :
    sa.name => sa
  }

  project = var.project_id
  member  = "serviceAccount:${google_service_account.service_accounts[each.key].email}"

  dynamic "role" {
    for_each = each.value.project_roles
    content {
      role = role.value
    }
  }
}

# 3️⃣ Assign SERVICE-ACCOUNT-LEVEL IAM Roles
resource "google_service_account_iam_member" "sa_roles" {
  for_each = {
    for sa in var.service_accounts :
    sa.name => sa
  }

  service_account_id = google_service_account.service_accounts[each.key].name
  member             = "serviceAccount:${google_service_account.service_accounts[each.key].email}"

  dynamic "role" {
    for_each = each.value.sa_roles
    content {
      role = role.value
    }
  }
}
