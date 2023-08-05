vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "Prod"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-Prod-Web-170"
vsphere_folder          = "Prod/Web"
vsphere_template        = "debian-12.0-prod"


name_prefix             = "web-node-v2"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "15"
resource_pool_type = "xxl"
name               = "web"
env                = "prod"

provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "local-data"
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


nomad_host_folder = ""
nomad_host_volumes = [
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "prod"
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

vault_consul_role_cluster_type = "prod-web"

