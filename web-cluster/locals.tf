locals {
  minio_vault_path     = "${var.nomad_node_class}/minio/web/${var.vsphere_datacenter}"
  s3_provisioned_disks = [
    {
      DEVICE_DRIVE              = "sdb"
      LABEL                     = "frank_cache"
      S3_HOST_1                 = "https://devtest.freenas.tmi.jhdc.local:9000"
      S3_MOUNT_1                = "/mnt/local/frank_mount"
      S3_UID_1                  = "1000"
      S3_GID_1                  = "4646"
      S3_ACL_1                  = "private"
      S3_CACHE_1                = "/mnt/local/frank_cache_cache"
      S3_BUCKET_1               = "frank-nomad"
      S3_ACCESS_KEY_1           = data.vault_generic_secret.minio_s3.data["access_key"]
      S3_SECRET_KEY_1           = data.vault_generic_secret.minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_1 = "true"
      S3_SSL_VERIFY_HOSTNAME_1  = "0"
    }
  ]
}