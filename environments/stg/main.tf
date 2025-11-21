terraform {
  required_version = ">= 1.3.0"

  backend "gcs" {
    bucket = var.backend_bucket
    prefix = "terraform/state/${var.environment}"
  }
}

# -------------------------
# VPC
# -------------------------
module "vpc" {
  source      = "../../modules/gcp-vpc-module"
  project_id  = var.project_id
  environment = var.environment
}

# -------------------------
# SUBNETS
# -------------------------
module "subnets" {
  source            = "../../modules/gcp-subnets-module"
  project_id        = var.project_id
  environment       = var.environment
  network_self_link = module.vpc.vpc_self_link

  subnets = var.subnets
}

# -------------------------
# FIREWALL
# -------------------------
module "firewall" {
  source            = "../../modules/gcp-firewall-module"
  project_id        = var.project_id
  environment       = var.environment
  network_self_link = module.vpc.vpc_self_link
  vpc_cidr          = var.vpc_cidr
  ssh_source_ranges = var.ssh_source_ranges
}

# -------------------------
# CLOUD NAT
# -------------------------
module "nat" {
  source            = "../../modules/gcp-nat-module"
  project_id        = var.project_id
  environment       = var.environment
  region            = var.region
  network_self_link = module.vpc.vpc_self_link
}

# -------------------------
# STORAGE BUCKET
# -------------------------
module "bucket" {
  source      = "../../modules/gcp-storage-module"
  project_id  = var.project_id
  environment = var.environment
  name_suffix = "appdata"
}

# -------------------------
# MULTI VM MODULE (RHEL)
# -------------------------
module "multi_vm" {
  source = "../../modules/gcp-multi-vm-module"

  project_id           = var.project_id
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
