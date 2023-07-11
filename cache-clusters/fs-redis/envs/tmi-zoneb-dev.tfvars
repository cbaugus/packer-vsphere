vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "NonProd"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-NonProd-DB-181"
vsphere_folder          = "NonProd/Cache"
vsphere_template        = "debian-12-prod"


name_prefix             = "fs-redis"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "2"
resource_pool_type = "xl"
name               = "fs-redis"
env                = "dev"

provisioned_disks = [
]

#NFS Vars for Prod
nfs_configure      = ""
nfs_mount_server   = ""
nfs_mount_options  = ""
nfs_mount_path     = ""


nomad_host_folder = ""
nomad_host_volumes = [
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "dev"
nomad_purpose               = "fs-redis"
nomad_vault_address         = "https://vault.service.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "fs-redis"
}

nomad_plugins = {
}

vault_consul_role_cluster_type = "prod-dbcluster"

vault_server_url = "https://vault.service.tmi-zoneb.consul:8200"