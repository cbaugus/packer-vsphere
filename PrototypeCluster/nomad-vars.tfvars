nomad_user                         = "nomad"
nomad_group_name                   = "nomad_instances"
nomad_group                        = "nomad"
nomad_leave_on_terminate           = "yes"
nomad_leave_on_interrupt           = "yes"
nomad_version                      = "1.1.2"
nomad_vault_enabled                = "True"
nomad_vault_address                = "https://vault.service.consul:8200"
nomad_vault_create_from_role       = "nomad-cluster"
nomad_vault_cert_file              = "/opt/vault/tls/tls.crt"
nomad_vault_key_file               = "/opt/vault/tls/tls.key"
nomad_vault_tls_skip_verify        = "True"
nomad_telemetry                    = "true"
nomad_telemetry_prometheus_metrics = "true"
nomad_docker_enable                = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
  "docker.cleanup.image"   = "false"
  "docker.volumes.enabled" = "true"
}
nomad_meta = {
  "node-switcher" = "on"
  "system-fab-lb" = "on"
  "purpose"       = "operations"
}