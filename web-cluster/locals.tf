locals {
  minio_vault_path = "${var.env}/minio/${var.name}/${var.vsphere_datacenter}"
  #consul_token_vault_path = "consul/creds/${var.name}-node"
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "${var.name}"
  }
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
  s3_provisioned_disks = [
    {
      S3_HOST_1                 = data.vault_generic_secret.minio_s3.data["url"]
      S3_MOUNT_1                = "/mnt/local/frank_mount"
      S3_UID_1                  = "0"
      S3_GID_1                  = "2"
      S3_ACL_1                  = "private"
      S3_CACHE_1                = "/mnt/local/frank_cache"
      S3_BUCKET_1               = data.vault_generic_secret.minio_s3.data["bucket"]
      S3_ACCESS_KEY_1           = data.vault_generic_secret.minio_s3.data["access_key"]
      S3_SECRET_KEY_1           = data.vault_generic_secret.minio_s3.data["secret_key"]
      S3_NO_CHECK_CERTIFICATE_1 = "true"
      S3_SSL_VERIFY_HOSTNAME_1  = "0"
      S3_EXTRA_OPTS_1           = ""
    }
  ]
  nomad_region        = substr(var.vsphere_datacenter, 0, 3)
  nomad_vault_address = "https://vault.service.${var.vsphere_datacenter}.consul:8200"
  known_hosts_user = "root"
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
