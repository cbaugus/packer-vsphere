locals {
  cluster_name = "dbcache"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${local.cluster_name}"
  }
}