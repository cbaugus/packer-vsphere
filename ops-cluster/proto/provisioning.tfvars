provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "influxdb_label"
    disk_size                 = "large"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]

consul_addresses_http = "{{ consul_bind_address }} 127.0.0.1"

nomad_region                = "tmi"
nomad_node_class            = "proto"
nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
  "docker.cleanup.image"   = "false"
  "docker.volumes.enabled" = "true"
}
nomad_meta = {
  "node-switcher" = "on"
  "purpose"       = "ops"
}
// The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
// if that is being uses. The ansible nomad role will try to create the directory before configuring it in
// the client.hcl file.
nomad_host_volumes = [
  {
    "name"      = "influxdb"
    "path"      = "/mnt/local/influxdb"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  },
  {
    "name"      = "prometheus"
    "path"      = "/mnt/local/prometheus"
    "owner"     = "root"
    "group"     = "bin"
    "mode"      = "0777"
    "read_only" = "false"
  }
]

vault_consul_role_cluster_type = "ops"
vault_agent_templates = [
  {
    "name" = "consul-token"
    "template" = "[[ with secret \"consul/creds/{{ vault_consul_role_cluster_type }}-node\" ]][[ .Data.token ]][[ end ]]"
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
    "command" = "consul acl set-agent-token -token=`cat /opt/consul/acl-token.txt` default `cat /opt/consul/acl-token.txt`"
    "left_delimiter" = "[["
    "right_delimiter" = "]]"
  }
]
