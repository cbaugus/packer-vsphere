vsphere_datacenter      = "tmi-w01-dc01"
vsphere_compute_cluster = "tmi-w01-cl01-dev"
vsphere_resource_pool   = "tmi-w01-dc01/tmi-w01-cl01-dev/Resources"
vsphere_datastore       = "troy-nonprod-ds-vsan"
vsphere_network         = "tmi-w01-cl01-dev-vds02-pg-web-220"
vsphere_folder          = "nonprod/wvw"
vsphere_template        = "debian-11.6-nonprod"


name_prefix             = "wvw-v2"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "1"
resource_pool_type = "xl"
name               = "wvw-v2"
env                = "dev"

provisioned_disks = [
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

nomad_region                = "tmi"
nomad_node_class            = "prod"
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

