# GCP Enterprise Cloud Storage Bucket Module

This module creates a secure, enterprise-grade GCP Cloud Storage bucket with:
- Versioning (optional)
- Retention policies (optional)
- Lifecycle rules
- KMS encryption
- Environment-based naming convention
- Public access prevention

## Example

```
module "bucket" {
  source      = "../../modules/gcp-storage"
  project_id  = var.project_id
  environment = "dev"
  name_suffix = "healthcare"

  enable_versioning = true
  force_destroy     = false

  labels = {
    app = "healthcare"
    env = "dev"
  }

  lifecycle_rules = [
    {
      action = {
        type          = "SetStorageClass"
        storage_class = "NEARLINE"
      }
      condition = {
        age = 30
      }
    }
  ]
}
```
