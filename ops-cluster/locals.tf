locals {
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${var.name}"
  }
  consul_node_meta = {
    "purpose" = "${var.name}"
    "class"   = "${var.env}"
    "version" = "{{ consul_version }}"
  }
  nomad_region        = substr(var.vsphere_datacenter, 0, 3)
  nomad_vault_address = "https://vault.service.${var.vsphere_datacenter}.consul:8200"
  known_hosts_user    = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]
  vault_agent_templates = [
    {
      "name"     = "consul-token"
      "template" = "[[ with secret \"consul/creds/${var.env == "prod" ? "prod" : "nonprod"}-{{ vault_consul_role_cluster_type }}-node\" ]][[ .Data.token ]][[ end ]]"
      "destination" = {
        "path"                   = "/opt/consul/acl-token.txt"
        "setup_parent_directory" = true
        "parent_directory" = {
          "owner" = "consul"
          "group" = "consul"
          "mode"  = ""
        }
      }
      "perms"           = "0644"
      "command"         = "consul acl set-agent-token -token=`cat /opt/consul/acl-token.txt` agent `cat /opt/consul/acl-token.txt`"
      "left_delimiter"  = "[["
      "right_delimiter" = "]]"
    }
  ]
  vsphere_folder = "${var.env}/${var.name}"
}