
locals {
  // streaming_minio_vault_path     = "${var.nomad_node_class}/minio/streaming"
  // streaming_public_minio_vault_path     = "${var.nomad_node_class}/minio/streaming_public"
  growr_provisioned_disks = [
    {
      DEVICE_DRIVE              = "sdb"
      LABEL                     = "data"
    }
  ]

  known_hosts_user = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]

}
