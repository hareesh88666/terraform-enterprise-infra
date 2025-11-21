variable "project_id" {}
variable "backend_bucket" {}
variable "environment" {}
variable "region" {
  default = "asia-south1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "ssh_source_ranges" {
  type    = list(string)
  default = ["YOUR_IP/32"]
}

variable "subnets" {
  type = list(object({
    name          = string
    region        = string
    ip_cidr_range = string
  }))
  default = [
    {
      name          = "private-1"
      region        = "asia-south1"
      ip_cidr_range = "10.0.1.0/24"
    },
    {
      name          = "public-1"
      region        = "asia-south1"
      ip_cidr_range = "10.0.101.0/24"
    }
  ]
}
