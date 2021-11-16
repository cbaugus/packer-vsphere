locals {
  minio_vault_path        = "${var.env}/minio/web/${var.vsphere_datacenter}"
  cluster_name            = "web"
  consul_token_vault_path = "consul/creds/${local.cluster_name}-node"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${local.cluster_name}"
  }
  growr_provisioned_disks = [
    {
      DEVICE_DRIVE = "sdb"
      LABEL        = "frank"
    }
  ]
  s3_provisioned_disks = [
    {
      S3_HOST_1                 = "https://${var.minio_url}:9000"
      S3_MOUNT_1                = "/mnt/local/frank_mount"
      S3_UID_1                  = "0"
      S3_GID_1                  = "2"
      S3_ACL_1                  = "private"
      S3_CACHE_1                = "/mnt/local/frank_cache"
      S3_BUCKET_1               = "frank-nomad"
      S3_ACCESS_KEY_1           = data.vault_generic_secret.minio_s3.data["access_key"]
      S3_SECRET_KEY_1           = data.vault_generic_secret.minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_1 = "true"
      S3_SSL_VERIFY_HOSTNAME_1  = "0"
    }
  ]
}
