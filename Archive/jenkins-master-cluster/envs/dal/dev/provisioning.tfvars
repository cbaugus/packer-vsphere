minio_s3_url = "https://prod.freenas.dal.jhdc.local:9000/"

provisioned_disks = [
  {
    label = "jenkins-master"
    disk_size = "large"
    thin_provisioned = "true"
    eagerly_scrub = "false"
    data_disk_scsi_controller = "0"
  }
]

nomad_region                = "dal"
nomad_node_class            = "dev"
nomad_vault_address         = "https://vault.service.dal-w01-dc01.consul:8200"
nomad_vault_tls_skip_verify = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
  "docker.cleanup.image"   = "false"
  "docker.volumes.enabled" = "true"
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
      "group" = "nomad"
      "mode" = "0777"
      "read_only" = "false"
  }
]

vault_consul_role_cluster_type = "jenkins-master"
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
