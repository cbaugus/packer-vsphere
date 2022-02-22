
//provisioned_disks = [
//  {
//    label = "wowza_content_s3_cache"
//    disk_size = "xl"
//    thin_provisioned = "true"
//    eagerly_scrub = "false"
//    data_disk_scsi_controller = "0"
//  }
//]

provisioned_disks = []

nomad_region                = "tmi"
nomad_node_class            = "dev"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "streaming"
}
// The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
// if that is being uses. The ansible nomad role will try to create the directory before configuring it in
// the client.hcl file.
//nomad_host_volumes = [
//  {
//      "name" = "frank-wowza-content"
//      "path" = "/mnt/local/wowza_content_s3_mount"
//      "owner" = "root"
//      "group" = "bin"
//      "mode" = "0777"
//      "read_only" = "false"
//  },
//  {
//      "name" = "frank-wowza-content-public"
//      "path" = "/mnt/local/wowza_content_s3_mount_public"
//      "owner" = "root"
//      "group" = "bin"
//      "mode" = "0777"
//      "read_only" = "false"
//  }
//]

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

vault_consul_role_cluster_type = "streaming"
