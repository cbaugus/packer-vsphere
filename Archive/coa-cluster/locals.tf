
locals {

  cluster_name = "coa"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${local.cluster_name}"
  }

  growr_provisioned_disks = [
    {
      DEVICE_DRIVE              = "sdb"
      LABEL                     = "coa"
    }
  ]

  s3_provisioned_disks = [
    {
      S3_HOST_1                 = ""
      S3_MOUNT_1                = ""
      S3_UID_1                  = ""
      S3_GID_1                  = ""
      S3_ACL_1                  = ""
      S3_CACHE_1                = ""
      S3_BUCKET_1               = ""
      S3_ACCESS_KEY_1           = ""
      S3_SECRET_KEY_1           = ""
      S3_NO_CHECK_CERTIFICATE_1 = ""
      S3_SSL_VERIFY_HOSTNAME_1  = ""
    }
  ]
}