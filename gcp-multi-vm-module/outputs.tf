output "vm_names" {
  value = { for k, v in google_compute_instance.vm : k => v.name }
}

output "vm_self_links" {
  value = { for k, v in google_compute_instance.vm : k => v.self_link }
}
