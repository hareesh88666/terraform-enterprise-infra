output "service_account_emails" {
  description = "Service account emails created"
  value = {
    for k, v in google_service_account.service_accounts : k => v.email
  }
}
