# GCP Enterprise NAT Module

This module creates Cloud Router + Cloud NAT for private subnets.

## Features
- Cloud Router with BGP
- Cloud NAT with auto/manual IP allocation
- Supports NAT logs
- Supports LIST_OF_SUBNETWORKS (fine-grained NAT control)
- Best practice defaults for enterprise deployments

## Example

```
module "nat" {
  source            = "../../modules/gcp-nat"
  project_id        = var.project_id
  environment       = "dev"
  name_suffix       = "healthcare"
  region            = "asia-south1"
  network_self_link = module.vpc.vpc_self_link

  subnet_nat_option = "LIST_OF_SUBNETWORKS"

  subnetwork_list = [
    {
      name = module.subnets.subnet_self_links["app-private-1"]
      source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
    }
  ]
}
```
