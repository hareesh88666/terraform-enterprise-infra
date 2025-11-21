# GCP Enterprise IAM Module

This module creates service accounts and assigns IAM roles following enterprise best practices.

## Features
- Create multiple service accounts
- Assign multiple project-level roles to each SA
- Assign multiple service-account-level roles
- Consistent naming: <env>-<sa_name>
- Works across dev/qa/stage/prod

---

## Example Usage

```
module "iam" {
  source      = "../../modules/gcp-iam"
  project_id  = var.project_id
  environment = "dev"

  service_accounts = [
    {
      name          = "gke-sa"
      display_name  = "GKE Service Account"
      project_roles = [
        "roles/logging.logWriter",
        "roles/monitoring.metricWriter"
      ]
      sa_roles = []
    },
    {
      name          = "cloudrun-sa"
      display_name  = "Cloud Run SA"
      project_roles = ["roles/run.admin"]
      sa_roles      = []
    }
  ]
}
```

---

## Outputs
- `service_account_emails` — Map of created service accounts and their emails
