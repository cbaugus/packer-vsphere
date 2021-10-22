
locals {
  minio_vault_path     = "${var.nomad_node_class}/minio/streaming/${var.vsphere_datacenter}"
  growr_provisioned_disks = [
    {
      DEVICE_DRIVE              = "sdb"
      LABEL                     = "wowza_content_s3_cache"
    }
  ]
  s3_provisioned_disks = [
    {
      S3_HOST_1 = "${var.minio_s3_url}"
      S3_MOUNT_1 = "/mnt/local/wowza_content_s3_mount"
      S3_UID_1 = "0"
      S3_GID_1 = "2"
      S3_ACL_1 = "private"
      S3_CACHE_1 = "/mnt/local/wowza_content_s3_cache"
      S3_BUCKET_1 = "streaming-wowza-video-${var.nomad_node_class}"
      S3_ACCESS_KEY_1           = data.vault_generic_secret.minio_s3.data["access_key"]
      S3_SECRET_KEY_1           = data.vault_generic_secret.minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_1 = "true"
      S3_SSL_VERIFY_HOSTNAME_1 = "0"
    }
  ]
}
