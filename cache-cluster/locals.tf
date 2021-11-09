locals {
  cluster_name = "cache"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${local.cluster_name}"
  }
}