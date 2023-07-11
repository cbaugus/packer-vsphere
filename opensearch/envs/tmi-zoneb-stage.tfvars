vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "NonProd"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-NonProd-DB-181"
vsphere_folder          = "NonProd/Database"
vsphere_template        = "debian-12-prod"


name_prefix             = "opensearch"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "3"
resource_pool_type = "xl"
name               = "opensearch"
env                = "stage"

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


nomad_host_folder = "/mnt/local/opensearch"
nomad_host_volumes = [
  {
    "name"      = "opensearch"
    "path"      = "/mnt/local/opensearch"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  },
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "stage"
nomad_purpose               = "opensearch"
nomad_vault_address         = "https://vault.service.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "opensearch"
}

nomad_plugins = {
}

vault_consul_role_cluster_type = ""

vault_server_url = "https://vault.service.tmi-zoneb.consul:8200"