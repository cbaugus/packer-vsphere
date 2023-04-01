vsphere_datacenter      = "TMI"
vsphere_compute_cluster = "Zone-B"
vsphere_resource_pool   = "TMI/Zone-B/NonProd"
vsphere_datastore       = "Zone-B-vSAN"
vsphere_network         = "ZoneB-Prod-OPS-175"
vsphere_folder          = "NonProd/wvw"
vsphere_template        = "debian-11.6-prod"


name_prefix             = "wvw-v2"
consul_datacenter   = "tmi-zonb"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "1"
resource_pool_type = "xl"
name               = "wvw-v2"
env                = "dev"

provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "wvw-data"
    disk_size                 = "large"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]

#NFS Vars for Prod
nfs_mount_server   = "10.254.225.97:/mnt/disk-pool/nfs-root"
nfs_mount_options  = "rw,nolock,hard,rsize=8192,wsize=8192,timeo=30,vers=3"
nfs_mount_path     = "/mnt/nfs/nonprod"


nomad_host_volumes = [
  {
    "name"      = "frank-nfs-prod"
    "path"      = "/mnt/nfs/nonprod/wvw/dev"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  },
]

nomad_datacenter            = "tmi"
nomad_region                = "zoneb"
nomad_node_class            = "dev"
nomad_purpose               = "web"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "wvw"
}


// https://man7.org/linux/man-pages/man7/capabilities.7.html
// https://www.nomadproject.io/docs/configuration/plugin
nomad_plugins = {
  "docker" = {
    "config" = {
      "auth" = {
        //"config" = "/etc/docker-auth.json"
        "helper" = "vault-login"
      }
      "gc" = {
        "image" = true
      }
      "volumes" = {
        "enabled" = true
      }
    }
  }
}

docker_vault_login = {
  "config_path" = "/etc/vault/agent.hcl"
}

vault_docker_secrets = [
  {
    "registry" = "docker.io"
    "secret" = "ops/data/docker"
  }
]

vault_consul_role_cluster_type = "nonprod-web"

