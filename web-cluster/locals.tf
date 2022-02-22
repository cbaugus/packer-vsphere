locals {
  minio_vault_path = toset(
    [
      "${var.env}/minio/${var.name}/${var.vsphere_datacenter}",

    ]
  )
  #consul_token_vault_path = "consul/creds/${var.name}-node"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${var.name}"
  }
  //  nomad_host_volumes = [for secret in data.vault_generic_secret.minio_s3 :
  //    {
  //      "name"      = "frank-nomad"
  //      "path"      = "${secret.data["host_mount_path"]}/default/files"
  //      "owner"     = "root"
  //      "group"     = "bin"
  //      "mode"      = "0777"
  //      "read_only" = "false"
  //    }
  //  ]
  // Uncomment this section when deploying for nonprod

  nomad_host_volumes = [
    /*
    {
      "name"      = "frank-nomad-dev"
      "path"      = "${data.vault_generic_secret.dev_minio_s3.data["host_mount_path"]}/default/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },
    {
      "name"      = "frank-nomad-test"
      "path"      = "${data.vault_generic_secret.test_minio_s3.data["host_mount_path"]}/default/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },
    {
      "name"      = "frank-nomad-stage"
      "path"      = "${data.vault_generic_secret.stage_minio_s3.data["host_mount_path"]}/default/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },
  */
    // Uncomment this section when deploying for prod
    {
      "name"      = "frank-nomad-prod"
      "path"      = "${data.vault_generic_secret.prod_minio_s3.data["host_mount_path"]}/default/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },
  ]
  consul_node_meta = {
    "purpose" = "${var.name}"
    "class"   = "${var.env}"
    "version" = "{{ consul_version }}"
  }
  growr_provisioned_disks = [
    {
      DEVICE_DRIVE = "sdb"
      LABEL        = "frank"
    }
  ]
  //    s3_provisioned_disks = [ for secret in data.vault_generic_secret.minio_s3 :
  //    {
  //      S3_HOST_1                 = secret.data["url"]
  //      S3_MOUNT_1                = secret.data["host_mount_path"]
  //      S3_UID_1                  = "0"
  //      S3_GID_1                  = "2"
  //      S3_ACL_1                  = "private"
  //      S3_CACHE_1                = secret.data["host_cache_path"]
  //      S3_BUCKET_1               = secret.data["bucket"]
  //      S3_ACCESS_KEY_1           = secret.data["access_key"]
  //      S3_SECRET_KEY_1           = secret.data["secret_key"]
  //      S3_NO_CHECK_CERTIFICATE_1 = "true"
  //      S3_SSL_VERIFY_HOSTNAME_1  = "0"
  //      S3_EXTRA_OPTS_1           = ""
  //    }
  //    ]
  // Uncomment this section when deploying for nonprod
  s3_provisioned_disks = [
    /*
    {
      S3_HOST_1                 = data.vault_generic_secret.dev_minio_s3.data["url"]
      S3_MOUNT_1                = data.vault_generic_secret.dev_minio_s3.data["host_mount_path"]
      S3_UID_1                  = "0"
      S3_GID_1                  = "2"
      S3_ACL_1                  = "private"
      S3_CACHE_1                = data.vault_generic_secret.dev_minio_s3.data["host_cache_path"]
      S3_BUCKET_1               = data.vault_generic_secret.dev_minio_s3.data["bucket"]
      S3_ACCESS_KEY_1           = data.vault_generic_secret.dev_minio_s3.data["access_key"]
      S3_SECRET_KEY_1           = data.vault_generic_secret.dev_minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_1 = "true"
      S3_SSL_VERIFY_HOSTNAME_1  = "0"
      S3_EXTRA_OPTS_1           = ""
    },
    {
      S3_HOST_2                 = data.vault_generic_secret.test_minio_s3.data["url"]
      S3_MOUNT_2                = data.vault_generic_secret.test_minio_s3.data["host_mount_path"]
      S3_UID_2                  = "0"
      S3_GID_2                  = "2"
      S3_ACL_2                  = "private"
      S3_CACHE_2                = data.vault_generic_secret.test_minio_s3.data["host_cache_path"]
      S3_BUCKET_2               = data.vault_generic_secret.test_minio_s3.data["bucket"]
      S3_ACCESS_KEY_2           = data.vault_generic_secret.test_minio_s3.data["access_key"]
      S3_SECRET_KEY_2           = data.vault_generic_secret.test_minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_2 = "true"
      S3_SSL_VERIFY_HOSTNAME_2  = "0"
      S3_EXTRA_OPTS_2           = ""
    },
    {
      S3_HOST_3                 = data.vault_generic_secret.stage_minio_s3.data["url"]
      S3_MOUNT_3                = data.vault_generic_secret.stage_minio_s3.data["host_mount_path"]
      S3_UID_3                  = "0"
      S3_GID_3                  = "2"
      S3_ACL_3                  = "private"
      S3_CACHE_3                = data.vault_generic_secret.stage_minio_s3.data["host_cache_path"]
      S3_BUCKET_3               = data.vault_generic_secret.stage_minio_s3.data["bucket"]
      S3_ACCESS_KEY_3           = data.vault_generic_secret.stage_minio_s3.data["access_key"]
      S3_SECRET_KEY_3           = data.vault_generic_secret.stage_minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_3 = "true"
      S3_SSL_VERIFY_HOSTNAME_3  = "0"
      S3_EXTRA_OPTS_3           = ""
    }
  */
    // Uncomment this section when deploying for prod
    {
      S3_HOST_1                 = data.vault_generic_secret.prod_minio_s3.data["url"]
      S3_MOUNT_1                = data.vault_generic_secret.prod_minio_s3.data["host_mount_path"]
      S3_UID_1                  = "0"
      S3_GID_1                  = "2"
      S3_ACL_1                  = "private"
      S3_CACHE_1                = data.vault_generic_secret.prod_minio_s3.data["host_cache_path"]
      S3_BUCKET_1               = data.vault_generic_secret.prod_minio_s3.data["bucket"]
      S3_ACCESS_KEY_1           = data.vault_generic_secret.prod_minio_s3.data["access_key"]
      S3_SECRET_KEY_1           = data.vault_generic_secret.prod_minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_1 = "true"
      S3_SSL_VERIFY_HOSTNAME_1  = "0"
      S3_EXTRA_OPTS_1           = ""
    },
  ]
  nomad_region        = substr(var.vsphere_datacenter, 0, 3)
  nomad_vault_address = "https://vault.service.${var.vsphere_datacenter}.consul:8200"
  known_hosts_user    = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]
  vault_agent_templates = [
    {
      "name"     = "consul-token"
      "template" = "[[ with secret \"consul/creds/${var.env == "prod" ? "prod" : "nonprod"}-{{ vault_consul_role_cluster_type }}-node\" ]][[ .Data.token ]][[ end ]]"
      "destination" = {
        "path"                   = "/opt/consul/acl-token.txt"
        "setup_parent_directory" = true
        "parent_directory" = {
          "owner" = "consul"
          "group" = "consul"
          "mode"  = ""
        }
      }
      "perms"           = "0644"
      "command"         = "consul acl set-agent-token -token=`cat /opt/consul/acl-token.txt` agent `cat /opt/consul/acl-token.txt`"
      "left_delimiter"  = "[["
      "right_delimiter" = "]]"
    }
  ]
  vsphere_folder = "${var.env}/${var.name}"
}
