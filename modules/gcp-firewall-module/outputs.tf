output "firewall_rules" {
  description = "Firewall rule names"
  value = [
    google_compute_firewall.allow_internal.name,
    try(google_compute_firewall.allow_ssh[0].name, null),
    google_compute_firewall.allow_iap.name,
    google_compute_firewall.allow_health_checks.name,
    google_compute_firewall.deny_all_ingress.name
  ]
}
