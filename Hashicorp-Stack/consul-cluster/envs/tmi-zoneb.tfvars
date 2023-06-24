vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "Prod"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-Prod-OPS-175"
vsphere_folder          = "Prod/OPS/Consul"
vsphere_template        = "debian-12-prod"


name_prefix             = "consul"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "3"
resource_pool_type = "xxl"
name               = "consul"
env                = "prod"

provisioned_disks = [
]

nomad_host_volumes = [
]

nomad_region                = "tmi"
nomad_node_class            = "prod"
nomad_purpose               = "consul"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "consul"
}


// https://man7.org/linux/man-pages/man7/capabilities.7.html
// https://www.nomadproject.io/docs/configuration/plugin
nomad_plugins = {
}

docker_vault_login = {
}

vault_docker_secrets = [
]

vault_consul_role_cluster_type = "nonprod-web"

