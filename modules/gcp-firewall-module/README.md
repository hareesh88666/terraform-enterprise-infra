# GCP Enterprise Firewall Module

This module implements enterprise-standard firewall rules for your VPC.

## Features
- Allow internal VPC communication
- Allow SSH only from trusted IPs
- Allow IAP access (Google recommended for secure SSH/RDP)
- Allow Google health checks
- Deny all other ingress traffic (default-deny model)

## Example usage

```
module "firewall" {
  source            = "../../modules/gcp-firewall"
  project_id        = var.project_id
  environment       = "dev"
  name_suffix       = "healthcare"
  network_self_link = module.vpc.vpc_self_link
  vpc_cidr          = "10.0.0.0/16"

  ssh_source_ranges = ["YOUR_IP/32"]
}
```
