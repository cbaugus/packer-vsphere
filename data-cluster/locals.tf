locals {
  minio_vault_path     = "${var.nomad_node_class}/minio/streaming/${var.vsphere_datacenter}"
  growr_provisioned_disks = [
    {
      DEVICE_DRIVE              = "sdb"
      LABEL                     = "mongodb_data"
    },
    {
      DEVICE_DRIVE              = "sdc"
      LABEL                     = "redis_data"
    }
  ]
  s3_provisioned_disks = []
}
