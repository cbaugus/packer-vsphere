vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "OPS"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "175-OPS-ZoneB-Prod"
vsphere_folder          = "Prod/ops"
vsphere_template        = "debian-11.6-prod"


name_prefix             = "mysql-speech"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "4"
resource_pool_type = "xl"
name               = "ops"
env                = "prod"

provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "prometheus"
    disk_size                 = "xxxxl"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]

#NFS Vars for Prod
nfs_configure      = "false"
nfs_mount_server   = "10.254.225.97:/mnt/disk-pool/nfs-root"
nfs_mount_options  = "rw,nolock,hard,rsize=8192,wsize=8192,timeo=30,vers=3"
nfs_mount_path     = "/mnt/nfs/nonprod"


nomad_host_folder = "/mnt/local/prometheus"
nomad_host_volumes = [
  {
    "name"      = "prometheus"
    "path"      = "/mnt/local/prometheus"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  },
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "prod"
nomad_purpose               = "ops"
nomad_vault_address         = "https://vault.service.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "ops"
}

nomad_plugins = {
}

vault_consul_role_cluster_type = "prod-ops"

vault_server_url = "https://vault.service.tmi-zoneb.consul:8200"