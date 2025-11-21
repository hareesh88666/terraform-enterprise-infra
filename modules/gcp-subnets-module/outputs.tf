output "subnet_self_links" {
  description = "Map of subnet name to self_link"
  value = { for k, v in google_compute_subnetwork.this : k => v.self_link }
}

output "subnet_ids" {
  description = "Map of subnet name to id"
  value = { for k, v in google_compute_subnetwork.this : k => v.id }
}

output "subnet_names" {
  description = "List of subnet names created"
  value = keys(google_compute_subnetwork.this)
}

output "subnetwork_self_links" {
  description = "Map of subnet name to self_link"
  value = { for k, v in google_compute_subnetwork.this : k => v.self_link }
}

