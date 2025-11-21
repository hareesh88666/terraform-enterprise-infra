# GCP Enterprise Subnets Module

This module creates GCP subnets (google_compute_subnetwork) in a VPC network. It's designed as the Step 2 of the enterprise VPC implementation.

## Design goals
- Reusable across environments
- Support for multiple regions/AZs
- Optional flow logs and private Google access
- Accepts either `network_self_link` (preferred) or `network_name`

## Example usage

```hcl
module "subnets" {
  source           = "../../modules/gcp-subnets"
  project_id       = var.project_id
  environment      = "dev"
  network_self_link = module.vpc.vpc_self_link

  subnets = [
    {
      name          = "app-private-1"
      region        = "asia-south1"
      ip_cidr_range = "10.0.1.0/24"
      private_ip_google_access = true
    },
    {
      name          = "app-public-1"
      region        = "asia-south1"
      ip_cidr_range = "10.0.101.0/24"
    }
  ]
  enable_flow_logs = true
}
```

## Notes
- Use `module.vpc.vpc_self_link` as `network_self_link`.
- For production, ensure proper CIDR planning and region distribution.

## Reference image (uploaded by you)
The original image you provided is included in this package at:

`/mnt/data/883a501c-d3be-460c-ab9b-c801f6ed8ffa.png`

You can use it as a diagram or documentation asset.
