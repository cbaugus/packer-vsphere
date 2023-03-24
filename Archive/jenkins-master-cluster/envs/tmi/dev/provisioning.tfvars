minio_s3_url = "https://b.nonprod.s3.tmi.jhdc.local:9000/"

provisioned_disks = [
  {
    device_drive = "sdb"
    label = "jenkins-master-cache"
    disk_size = "large"
    thin_provisioned = "true"
    eagerly_scrub = "false"
    data_disk_scsi_controller = "0"
  }
]

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
  "purpose"       = "jenkins-master"
}
// The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
// if that is being uses. The ansible nomad role will try to create the directory before configuring it in
// the client.hcl file.
nomad_host_volumes = [
  {
      "name" = "jenkins-master"
      "path" = "/mnt/local/jenkins-master"
      "owner" = "cicduser"
      "group" = "cicduser"
      "mode" = "0777"
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

vault_consul_role_cluster_type = "jenkins-master"
vault_agent_templates = [
  {
    "name" = "consul-token"
    "template" = "[[ with secret \"consul/creds/nonprod-{{ vault_consul_role_cluster_type }}-node\" ]][[ .Data.token ]][[ end ]]"
    "destination" = {
      "path" = "/opt/consul/acl-token.txt"
      "setup_parent_directory" = true
      "parent_directory" = {
        "owner" = "consul"
        "group" = "consul"
        "mode"  = ""
      }
    }
    "perms" = "0644"
    "command" = "consul acl set-agent-token -token=`cat /opt/consul/acl-token.txt` agent `cat /opt/consul/acl-token.txt`"
    "left_delimiter" = "[["
    "right_delimiter" = "]]"
  },
//  {
//    "name" = "docker-auth"
//    "template" = "{\"auths\": {\"https://index.docker.io/v1/\": {\"username\": \"[[ with secret \"ops/docker\" ]][[ .Data.data.username ]][[ end ]]\", \"password\": \"[[ with secret \"ops/docker\" ]][[ .Data.data.password ]][[ end ]]\" } } }"
//    "destination" = {
//      "path" = "/etc/docker/docker-auth.json"
//    }
//    "perms" = "0644"
//    "left_delimiter" = "[["
//    "right_delimiter" = "]]"
//  }
]
