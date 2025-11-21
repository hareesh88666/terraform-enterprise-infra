# GCP Multi VM Module (RHEL Default)

This module lets you create multiple VMs using a single module input.

## Example

module "multi_vm" {
  source = "../../modules/gcp-multi-vm-module"

  project_id = var.project_id
  subnetwork_self_link = module.subnets.subnetwork_self_links["private-1"]

  vms = {
    backend = {
      vm_name          = "backend-rhel"
      zone             = "asia-south1-a"
      machine_type     = "e2-medium"
      assign_public_ip = false
    }
    frontend = {
      vm_name          = "frontend-rhel"
      zone             = "asia-south1-a"
      machine_type     = "e2-small"
      assign_public_ip = true
    }
  }
}
