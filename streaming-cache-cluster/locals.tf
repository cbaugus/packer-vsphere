
locals {
  minio_vault_path     = "${var.nomad_node_class}/minio/streaming/${var.vsphere_datacenter}"
  growr_provisioned_disks = []
  s3_provisioned_disks = []
}
