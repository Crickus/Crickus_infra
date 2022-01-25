output "app_external_ip" {
  value = "${module.app.app_pip}"
}

output "db_external_ip" {
  value = "${module.db.db_pip}"
}

output "db_internal_ip" {
  value = "${module.db.db_internal_ip}"
}

# output "Global Forwarding Rule IP" {
#   value = "${google_compute_forwarding_rule.lb_firewall.ip_address}"
# }

