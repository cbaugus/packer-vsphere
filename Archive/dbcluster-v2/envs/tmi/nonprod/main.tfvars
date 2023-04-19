name_prefix             = "nonprod-dbcluster"
consul_tls_src_files              = "/opt/devops-local/ssl/certs"
consul_src_def                    = "/opt/devops-local/ssl/certs"


vsphere_datacenter      = "tmi-w01-dc01"
vsphere_compute_cluster = "tmi-w01-cl01-dev"
vsphere_resource_pool   = "tmi-w01-dc01/tmi-w01-cl01-dev/Resources"
vsphere_datastore       = "troy-nonprod-ds-vsan"
vsphere_network         = "tmi-w01-cl01-dev-vds02-pg-db-222"
vsphere_folder          = "nonprod/database"
vsphere_template        = "debian-11.6-nonprod"


num_instances      = "3"
resource_pool_type = "xl"
name               = "dbcluster"
env                = "nonprod"




############# Provisioning Vars


provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "sdb_label"
    disk_size                 = "xxl"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]

growr_provisioned_disks = [
  {
    DEVICE_DRIVE              = "sdb"
    LABEL                     = "zookeeper_label"
  }
]

s3_provisioned_disks = []

nomad_region                = "tmi"
nomad_node_class            = "nonprod"
nomad_purpose               = "dbcluster"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "dbcluster"
}
// The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
// if that is being uses. The ansible nomad role will try to create the directory before configuring it in
// the client.hcl file.
nomad_host_volumes = [
  {
    "name"      = "data"
    "path"      = "/mnt/local/data"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  }
]

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

vault_consul_role_cluster_type = "nonprod-dbcluster"

