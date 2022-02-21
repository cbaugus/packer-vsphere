
locals {
  // streaming_minio_vault_path     = "${var.nomad_node_class}/minio/streaming"
  // streaming_public_minio_vault_path     = "${var.nomad_node_class}/minio/streaming_public"
  growr_provisioned_disks = [
    {
      DEVICE_DRIVE              = "sdb"
      LABEL                     = "wowza_content_s3_cache"
    }
  ]
  s3_provisioned_disks = []
  // s3_provisioned_disks = [
  //   {
  //     S3_HOST_1 = data.vault_generic_secret.streaming_minio_secrets.data["url"]
  //     S3_MOUNT_1 = "/mnt/local/wowza_content_s3_mount"
  //     S3_UID_1 = "0"
  //     S3_GID_1 = "2"
  //     S3_ACL_1 = "private"
  //     S3_CACHE_1 = ""
  //     S3_BUCKET_1 = data.vault_generic_secret.streaming_minio_secrets.data["bucket"]
  //     S3_ACCESS_KEY_1           = data.vault_generic_secret.streaming_minio_secrets.data["access_key"]
  //     S3_SECRET_KEY_1           = data.vault_generic_secret.streaming_minio_secrets.data["secret_key"]
  //     S3_NO_CHECK_CERTIFICATE_1 = "true"
  //     S3_SSL_VERIFY_HOSTNAME_1 = "0"
  //     S3_EXTRA_OPTS_1 = ""
  //   },
  //   {
  //     S3_HOST_2 = data.vault_generic_secret.streaming_public_minio_secrets.data["url"]
  //     S3_MOUNT_2 = "/mnt/local/wowza_content_s3_mount_public"
  //     S3_UID_2 = "0"
  //     S3_GID_2 = "2"
  //     S3_ACL_2 = "private"
  //     S3_CACHE_2 = ""
  //     S3_BUCKET_2 = data.vault_generic_secret.streaming_public_minio_secrets.data["bucket"]
  //     S3_ACCESS_KEY_2           = data.vault_generic_secret.streaming_public_minio_secrets.data["access_key"]
  //     S3_SECRET_KEY_2           = data.vault_generic_secret.streaming_public_minio_secrets.data["secret_key"]
  //     S3_NO_CHECK_CERTIFICATE_2 = "true"
  //     S3_SSL_VERIFY_HOSTNAME_2 = "0"
  //     S3_EXTRA_OPTS_2 = ""
  //   }
  // ]
  known_hosts_user = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]

  vault_agent_templates = [
    {
      "name" = "consul-token"
      "template" = "[[ with secret \"consul/creds/${var.env}-{{ vault_consul_role_cluster_type }}-node\" ]][[ .Data.token ]][[ end ]]"
      "destination" = {
        "path" = "/opt/consul/acl-token.txt"
        "setup_parent_directory" = true
        "parent_directory" = {
          "owner" = "consul"
          "group" = "consul"
          "mode"  = ""
        }
      }
      "perms" = "0644"
      "command" = "consul acl set-agent-token -token=`cat /opt/consul/acl-token.txt` default `cat /opt/consul/acl-token.txt`"
      "left_delimiter" = "[["
      "right_delimiter" = "]]"
    },
  //  {
  //    "name" = "docker-auth"
  //    "template" = "{\"auths\": {\"https://index.docker.io/v1/\": {\"username\": \"[[ with secret \"ops/docker\" ]][[ .Data.data.username ]][[ end ]]\", \"password\": \"[[ with secret \"ops/docker\" ]][[ .Data.data.password ]][[ end ]]\" } } }"
  //    "destination" = {
  //      "path" = "/etc/docker/docker-auth.json"
  //    }
  //    "perms" = "0644"
  //    "left_delimiter" = "[["
  //    "right_delimiter" = "]]"
  //  }
  ]
}
