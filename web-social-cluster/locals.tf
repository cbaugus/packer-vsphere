locals {
  cluster_name = "web-social"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${local.cluster_name}"
  }
  growr_provisioned_disks = []
  s3_provisioned_disks    = []
}
