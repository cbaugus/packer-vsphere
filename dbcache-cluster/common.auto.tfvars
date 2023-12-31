name                 = "dbcache"
consul_tls_src_files = "/opt/devops-local/ssl/certs"
consul_src_def       = "/opt/devops-local/ssl/certs"
remote_exec_ssh_key_file = "/opt/devops-local/ssl/keys/key.pem"
local_exec_ssh_key_file  = "/opt/devops-local/ssl/keys/key.pem"

nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
  "docker.cleanup.image"   = "false"
  "docker.volumes.enabled" = "true"
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
    "secret"   = "ops/data/docker"
  }
]
