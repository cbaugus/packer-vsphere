
locals {
  growr_provisioned_disks = []
  s3_provisioned_disks = []

  vault_agent_templates = [
    {
      "name" = "consul-token"
      "template" = "[[ with secret \"consul/creds/${var.env}-{{ vault_consul_role_cluster_type }}-node\" ]][[ .Data.token ]][[ end ]]"
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
}
