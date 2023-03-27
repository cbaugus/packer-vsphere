
locals {
  growr_provisioned_disks = []
  s3_provisioned_disks = []

  known_hosts_user = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]

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
      "command" = "consul acl set-agent-token -token=`cat /opt/consul/acl-token.txt` agent `cat /opt/consul/acl-token.txt`"
      "left_delimiter" = "[["
      "right_delimiter" = "]]"
    },
  ]
}
