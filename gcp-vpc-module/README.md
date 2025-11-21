# GCP Enterprise VPC Module

This module creates an enterprise-grade VPC on GCP with manual subnet mode.

## Features
- Manual subnet mode (`auto_create_subnetworks = false`)
- Regional routing
- Strict naming convention
- Fully reusable for all environments

## Example usage

```
module "vpc" {
  source      = "../../modules/gcp-vpc"
  project_id  = "my-gcp-project"
  environment = "dev"
  name_suffix = "healthcare"
}
```
