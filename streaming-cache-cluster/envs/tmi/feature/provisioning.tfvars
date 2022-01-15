minio_s3_url = "https://devtest.freenas.tmi.jhdc.local:9000/"

provisioned_disks = []

nomad_region                = "tmi"
nomad_node_class            = "feature"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "streaming-cache"
}
// The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
// if that is being uses. The ansible nomad role will try to create the directory before configuring it in
// the client.hcl file.
nomad_host_volumes = []

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

vault_consul_role_cluster_type = "streaming-cache"
