name                 = "ops"
consul_tls_src_files = "/opt/devops-local/ssl/certs"
consul_src_def       = "/opt/devops-local/ssl/certs"

nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
  "docker.cleanup.image"   = "false"
  "docker.volumes.enabled" = "true"
}

nomad_host_volumes = [
  {
    "name"      = "prometheus"
    "path"      = "/mnt/local/prometheus"
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

vault_consul_role_cluster_type = "ops"
vault_docker_secrets = [
  {
    "registry" = "docker.io"
    "secret"   = "ops/data/docker"
  }
]
