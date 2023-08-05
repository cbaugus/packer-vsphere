vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "Prod"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-Prod-Streaming-173"
vsphere_folder          = "Prod/Streaming"
vsphere_template        = "debian-12.0-prod"


name_prefix             = "streaming"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "4"
resource_pool_type = "xxxl"
name               = "streaming"
env                = "prod"

provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "data"
    disk_size                 = "small"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]

#NFS Vars for Prod
nfs_mount_server   = ""
nfs_mount_options  = ""
nfs_mount_path     = ""


nomad_host_volumes = [
  {
    "name"      = "host_volume"
    "path"      = "/mnt/local/"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  },
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "prod"
nomad_purpose               = "streaming"
nomad_vault_address         = "https://vault.service.tmi-zoneb.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "streaming"
}


// https://man7.org/linux/man-pages/man7/capabilities.7.html
// https://www.nomadproject.io/docs/configuration/plugin
nomad_plugins = {
}

docker_vault_login = {
}

vault_docker_secrets = [
]

vault_consul_role_cluster_type = "prod-streaming"

vault_server_url = "https://vault.service.tmi-zoneb.consul:8200"