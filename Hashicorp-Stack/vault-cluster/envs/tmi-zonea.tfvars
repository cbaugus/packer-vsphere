vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-A"
vsphere_resource_pool   = "OPS"
vsphere_datastore       = "Zone-A-vSAN"
vsphere_network         = "ZoneA-Prod-OPS-175"
vsphere_folder          = "Prod/ops/Vault"
vsphere_template        = "debian-12-prod"


name_prefix             = "vault"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "4"
resource_pool_type = "xxl"
name               = "vault"
env                = "prod"

provisioned_disks = [
]

nomad_host_volumes = [
]

nomad_region                = "tmi"
nomad_node_class            = "prod"
nomad_purpose               = "vault"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "vault"
}


// https://man7.org/linux/man-pages/man7/capabilities.7.html
// https://www.nomadproject.io/docs/configuration/plugin
nomad_plugins = {
}

docker_vault_login = {
}

vault_docker_secrets = [
]

vault_consul_role_cluster_type = "prod-ops"

