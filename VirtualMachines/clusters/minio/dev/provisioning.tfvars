remote_exec_user           = "cicduser"
remote_exec_timeout        = "3m"
remote_exec_command        = "echo Running the remote exec provisioner"
local_exec_user            = "cicduser"
path_to_ansible            = "../../ansible-deployments/main.yml"
ansible_python_interpreter = "/usr/bin/python3"

provisioned_disks = [
  {
    device_drive = "sdb"
    label = "minio_content_s3_label"
    disk_size = "large"
    thin_provisioned = "true"
    eagerly_scrub = "false"
    data_disk_scsi_controller = "0"
    LABEL_sdb = "minio_content_s3_cache"
    S3_HOST_1 = "https://nonprods3fs01.dal.jhdc.local:9000"
    S3_MOUNT_1 = "/mnt/local/minio_content_s3_mount"
    S3_UID_1 = "1000"
    S3_GID_1 = "1002"
    S3_ACL_1 = "private"
    S3_CACHE_1 = "/mnt/local/minio_content_s3_cache"
    S3_BUCKET_1 = "minio-dev"
    S3_ACCESS_KEY_1 = "minio_s3_minio_access_key"
    S3_SECRET_KEY_1 = "minio_s3_minio_secret_key"
    S3_NO_CHECK_CERTIFICATE_1 = "true"
    S3_SSL_VERIFY_HOSTNAME_1 = "0"
  }
]

consul_domain                     = "consul."
consul_group_name                 = "all"
consul_group                      = "consul"
consul_cloud_autodiscovery        = "True"
consul_tls_enable                 = "True"
consul_tls_ca_crt                 = "consul-agent-ca.pem"
consul_tls_server_crt             = "dc1-server-consul-0.pem"
consul_tls_server_key             = "dc1-server-consul-0-key.pem"
consul_tls_verify_incoming        = "False"
consul_tls_verify_outgoing        = "True"
consul_tls_verify_server_hostname = "False"
consul_node_role                  = "client"
consul_connect_enabled            = "True"
consul_syslog_enable               = "True"
consul_acl_enable                 = "True"
consul_acl_default_policy         = "allow"
consul_version                    = "1.9.4"
auto_encrypt                      = { "enabled" = "True" }
consul_ports                      = { "grpc" = "8502", "dns" = "8600", "http" = "8500", "https" = "-1", "rpc" = "8400", "serf_lan" = "8301", "serf_wan" = "8302", "server" = "8300" }

nomad_node_class                   = "develop"
nomad_user                         = "nomad"
nomad_group_name                   = "all"
nomad_group                        = "nomad"
nomad_manage_group                 = "yes"
nomad_leave_on_terminate           = "yes"
nomad_leave_on_interrupt           = "yes"
nomad_version                      = "1.1.2"
nomad_vault_enabled                = "True"
nomad_vault_address                = "https://vault.service.consul:8200"
nomad_vault_create_from_role       = "nomad-cluster"
nomad_vault_cert_file              = ""
nomad_vault_key_file               = ""
nomad_vault_tls_skip_verify        = "True"
nomad_telemetry                    = "true"
nomad_telemetry_prometheus_metrics = "true"
nomad_docker_enable                = "yes"
nomad_options = {
  "driver.raw_exec.enable" = "1"
  "driver.java.enable"     = "0"
  "docker.cleanup.image"   = "false"
  "docker.volumes.enabled" = "true"
}
nomad_meta = {
  "node-switcher" = "on"
  "system-fab-lb" = "on"
  "purpose"       = "minio"
}

// The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
// if that is being uses. The ansible nomad role will try to create the directory before configuring it in
// the client.hcl file.
nomad_host_volumes = [
  {
      "name" = "frank-minio-content"
      "path" = "/mnt/local/minio_content_s3_mount"
      "owner" = "cicduser"
      "group" = "nomad"
      "mode" = "0777"
      "read_only" = "false"
  }
]
