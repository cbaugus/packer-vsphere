vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "NonProd"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "181-DB-ZoneB-NonProd"
vsphere_folder          = "NonProd/Database"
vsphere_template        = "debian-11.6-prod"


name_prefix             = "proxysql"
consul_datacenter       = "tmi-zoneb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "2"
resource_pool_type = "xl"
name               = "proxysql"
env                = "nonprod"

provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "proxysql"
    disk_size                 = "xl"
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


nomad_host_folder = "/mnt/local/proxysql"
nomad_host_volumes = [
  {
    "name"      = "proxysql"
    "path"      = "/mnt/local/proxysql"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  },
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "nonprod"
nomad_purpose               = "proxysql-shared"
nomad_vault_address         = "https://vault.service.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "proxysql-shared"
}

nomad_plugins = {
}

vault_consul_role_cluster_type = "nonprod-dbcluster"

vault_server_url = "https://vault.service.tmi-zoneb.consul:8200"