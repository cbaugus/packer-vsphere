
locals {
  // streaming_minio_vault_path     = "${var.nomad_node_class}/minio/streaming"
  // streaming_public_minio_vault_path     = "${var.nomad_node_class}/minio/streaming_public"
  growr_provisioned_disks = [
   // {
   //   DEVICE_DRIVE              = "sdb"
   //   LABEL                     = "data"
   // }
  ]

  known_hosts_user = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]

  nomad_host_volumes = [
    /*
    {
      "name"      = "frank-nfs-dev"
      "path"      = "/mnt/nfs/nonprod/dev/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },
    {
      "name"      = "frank-nfs-test"
      "path"      = "/mnt/nfs/nonprod/test/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },
    {
      "name"      = "frank-nfs-stage"
      "path"      = "/mnt/nfs/nonprod/stage/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },

    */

    // Uncomment this section when deploying for prod
    {
      "name"      = "frank-nfs-prod"
      "path"      = "/mnt/nfs/prod/prod/files"
      "owner"     = "root"
      "group"     = "bin"
      "mode"      = "0777"
      "read_only" = "false"
    },

  ]
}
