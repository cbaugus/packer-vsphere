locals {
  consul_node_meta = {
    "purpose" = "${var.name}"
    "class"   = "${var.env}"
    "version" = "{{ consul_version }}"
  }
  known_hosts_user = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]
  vsphere_folder = "ops/${var.name}"
}