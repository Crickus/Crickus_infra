output "app_external_ip2" {
  value = "${google_compute_instance.app.network_interface.0.access_config.0.nat_ip}"
}

# output "Global Forwarding Rule IP" {
#   value = "${google_compute_forwarding_rule.lb_firewall.ip_address}"
# }

