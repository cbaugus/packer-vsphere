vsphere_datacenter      = "tmi-w01-dc01"
vsphere_compute_cluster = "tmi-w01-cl01-prod"
vsphere_resource_pool   = "tmi-w01-dc01/tmi-w01-cl01-prod/Resources"
vsphere_datastore       = "tmi-w01-cl01-prod-ds-vsan01"
vsphere_network         = "tmi-w01-cl01-vds01-pg-ops-203"
vsphere_folder          = "prod/ops/worker"
vsphere_template        = "debian-11.6-prod"


name_prefix             = "web-v2"
consul_tls_src_files    = "/opt/devops-local/ssl/certs"
consul_src_def          = "/opt/devops-local/ssl/certs"

num_instances      = "2"
resource_pool_type = "xxl"
name               = "ops-worker"
env                = "prod"

provisioned_disks = [
]

nomad_region                = "tmi"
nomad_node_class            = "prod"
nomad_purpose               = "wev"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "web"
}
// The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
// if that is being uses. The ansible nomad role will try to create the directory before configuring it in
// the client.hcl file.
nomad_host_volumes = [
  {
    "name"      = "elastic"
    "path"      = "/mnt/local/elastic"
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

vault_consul_role_cluster_type = "prod"

