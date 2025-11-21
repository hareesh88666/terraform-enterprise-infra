variable "project_id" {
  type = string
}

variable "environment" {
  type = string
  default = "stg"
}

variable "name_suffix" {
  type = string
  default = "app"
}

variable "instance_name" {
  type = string
  description = "short name used in instance naming"
  default = "vm"
}

variable "zone" {
  type = string
  default = "asia-south1-a"
}

variable "region" {
  type = string
  default = "asia-south1"
}

variable "machine_type" {
  type = string
  default = "e2-medium"
}

variable "boot_disk_size_gb" {
  type = number
  default = 30
}

variable "boot_disk_type" {
  type = string
  default = "pd-standard"
}

variable "assign_public_ip" {
  type = bool
  default = true
}

variable "subnetwork_self_link" {
  type = string
  description = "Self-link of the subnetwork where VM will be attached"
}

variable "service_account_email" {
  type = string
  default = ""
}

variable "service_account_scopes" {
  type = list(string)
  default = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "startup_script" {
  type = string
  default = ""
}

variable "metadata" {
  type = map(string)
  default = {}
}

variable "tags" {
  type = list(string)
  default = []
}

variable "labels" {
  type = map(string)
  default = {}
}

variable "preemptible" {
  type = bool
  default = false
}

variable "automatic_restart" {
  type = bool
  default = true
}

variable "on_host_maintenance" {
  type = string
  default = "MIGRATE"
}

variable "depends_on" {
  type = list(any)
  default = []
}

# Image selection (RHEL by default)
variable "image_project" {
  type = string
  description = "Image project to fetch family from (e.g., rhel-cloud). Empty if using custom_image."
  default = "rhel-cloud"
}

variable "image_family" {
  type = string
  description = "Image family (e.g., rhel-8)"
  default = "rhel-8"
}

variable "custom_image" {
  type = string
  description = "Full self_link to a custom image if not using public image family"
  default = ""
}
