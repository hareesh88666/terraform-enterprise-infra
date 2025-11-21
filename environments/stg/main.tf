terraform {
  required_version = ">= 1.3.0"

  backend "gcs" {
    bucket = var.backend_bucket
    prefix = "terraform/state/${var.environment}"
  }
}

module "vpc" {
  source      = "../../modules/gcp-vpc-module"
  project_id  = var.project_id
  environment = var.environment
}

module "subnets" {
  source            = "../../modules/gcp-subnets-module"
  project_id        = var.project_id
  environment       = var.environment
  network_self_link = module.vpc.vpc_self_link

  subnets = var.subnets
}

module "firewall" {
  source            = "../../modules/gcp-firewall-module"
  project_id        = var.project_id
  environment       = var.environment
  network_self_link = module.vpc.vpc_self_link
  vpc_cidr          = var.vpc_cidr
  ssh_source_ranges = var.ssh_source_ranges
}

module "nat" {
  source            = "../../modules/gcp-nat-module"
  project_id        = var.project_id
  environment       = var.environment
  region            = var.region
  network_self_link = module.vpc.vpc_self_link
}

module "bucket" {
  source       = "../../modules/gcp-storage-module"
  project_id   = var.project_id
  environment  = var.environment
  name_suffix  = "appdata"
}
