locals {
  cluster_name = "coa-search"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${local.cluster_name}"
  }
}