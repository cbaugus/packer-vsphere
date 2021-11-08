locals {
  cluster_name            = "web-social"
  consul_token_vault_path = "consul/creds/${local.cluster_name}-node"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${local.cluster_name}"
  }
  growr_provisioned_disks = []
  s3_provisioned_disks    = []
}
