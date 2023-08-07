vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "NonProd"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-NonProd-Web-180"
vsphere_folder          = "NonProd/Web"
vsphere_template        = "debian-12.0-prod"


name_prefix             = "web-node"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "5"
resource_pool_type = "xl"
name               = "web"
env                = "dev"

provisioned_disks = [
]

#NFS Vars for Prod
nfs_mount_server   = ""
nfs_mount_options  = ""
nfs_mount_path     = ""


nomad_host_volumes = [
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "nonprod"
nomad_purpose               = "web"
nomad_vault_address         = "https://vault.service.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "web"
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

