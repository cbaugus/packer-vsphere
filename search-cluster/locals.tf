
locals {
  cluster_name            = "search-cluster"
  consul_token_vault_path = "consul/creds/${local.cluster_name}-node"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = local.cluster_name
  }
  growr_provisioned_disks = [
    {
      DEVICE_DRIVE              = "sdb"
      LABEL                     = "solr_label"
    }
  ]
  s3_provisioned_disks    = []
}
