vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "NonProd"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-NonProd-DB-181"
vsphere_folder          = "NonProd/Database"
vsphere_template        = "debian-12-prod"


name_prefix             = "rabbitmq"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "1"
resource_pool_type = "xl"
name               = "rabbitmq"
env                = "dev"

provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "data"
    disk_size                 = "xxl"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]

#NFS Vars for Prod
nfs_configure      = "false"
nfs_mount_server   = ""
nfs_mount_options  = ""
nfs_mount_path     = ""


nomad_host_folder = "/mnt/local/rabbitmq"
nomad_host_volumes = [
  {
    "name"      = "rabbitmq"
    "path"      = "/mnt/local/rabbitmq"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  },
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "dev"
nomad_purpose               = "rabbitmq"
nomad_vault_address         = "https://vault.service.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "rabbitmq"
}

nomad_plugins = {
}

vault_consul_role_cluster_type = "h"

vault_server_url = "https://vault.service.tmi-zoneb.consul:8200"