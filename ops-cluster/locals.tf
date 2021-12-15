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
}