variable "project_id" {
  type = string
}

variable "subnetwork_self_link" {
  type = string
}

variable "service_account_email" {
  type = string
  default = ""
}

variable "service_account_scopes" {
  type = list(string)
  default = ["https://www.googleapis.com/auth/cloud-platform"]
}

variable "default_boot_size" {
  type = number
  default = 30
}

variable "default_boot_type" {
  type = string
  default = "pd-standard"
}

# Multi VM definition
variable "vms" {
  type = map(object({
    vm_name          = string
    zone             = string
    machine_type     = string
    assign_public_ip = bool

    boot_disk_size_gb = optional(number)
    boot_disk_type    = optional(string)

    startup_script = optional(string)
    metadata       = optional(map(string))
    tags           = optional(list(string))
    labels         = optional(map(string))

    preemptible         = optional(bool)
    automatic_restart   = optional(bool)
    on_host_maintenance = optional(string)
  }))
}
