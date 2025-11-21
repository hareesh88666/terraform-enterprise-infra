# GCP VM Module (Enterprise) — RHEL-default

This Terraform module creates a Google Compute VM instance and is designed for enterprise usage.
It supports both public and private instances via `assign_public_ip` boolean,
and uses RHEL as the default OS (image_project = "rhel-cloud", image_family = "rhel-8").

## Features
- Public or private IP via `assign_public_ip`
- RHEL default image (changeable via variables)
- Service account & scopes
- Startup script (cloud-init or bash)
- Labels & tags
- Preemptible support
- Configurable boot disk size/type

## Usage example

module "vm" {
  source = "../../modules/gcp-vm-module"

  project_id = var.project_id
  environment = "stg"
  name_suffix = "backend"
  instance_name = "backend-01"
  zone = "asia-south1-a"
  machine_type = "e2-medium"

  subnetwork_self_link = module.subnets.subnet_self_links["private-1"]
  assign_public_ip = false

  image_project = "rhel-cloud"
  image_family  = "rhel-8"

  startup_script = <<-EOF
    #!/bin/bash
    echo "Hello from RHEL VM" > /var/tmp/hello.txt
  EOF

  labels = {
    env = "stg"
    app = "healthcare"
  }
}

## Note about RHEL images
RHEL images may require a subscription or licensing depending on the marketplace image you choose.
If your organization has a RHEL entitlement or uses a custom RHEL image, set `custom_image` to the image self_link
and leave `image_project` and `image_family` empty.

## Documentation asset
Included in this package is a diagram/image you previously uploaded. See `883a501c-d3be-460c-ab9b-c801f6ed8ffa.png`.
