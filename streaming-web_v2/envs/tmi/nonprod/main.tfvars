name_prefix             = "nonprod-streaming-web"
consul_tls_src_files              = "/opt/devops-local/ssl/certs"
consul_src_def                    = "/opt/devops-local/ssl/certs"


vsphere_datacenter      = "tmi-w01-dc01"
vsphere_compute_cluster = "tmi-w01-cl01-dev"
vsphere_resource_pool   = "tmi-w01-dc01/tmi-w01-cl01-dev/Resources"
vsphere_datastore       = "troy-nonprod-ds-vsan"
vsphere_network         = "tmi-w01-cl01-dev-vds02-pg-streaminga-226"
vsphere_folder          = "nonprod/streaming"
vsphere_template        = "debian-11.6-nonprod"


num_instances      = "2"
resource_pool_type = "medium"
name               = "streaming-web"
env                = "nonprod"




############# Provisioning Vars


provisioned_disks = []
s3_provisioned_disks = []

nomad_region                = "tmi"
nomad_node_class            = "nonprod"
nomad_purpose               = "streaming-web"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "streaming-web"
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

vault_consul_role_cluster_type = "nonprod-streaming"

