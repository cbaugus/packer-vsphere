locals {
  consul_cloud_autodiscovery_string = "provider=vsphere category_name=vmTags tag_name=consul host=${var.vsphere_server} user=${var.vsphere_user} password=${var.vsphere_pass} insecure_ssl=true timeout=2m"
  ansible_extra_vars = {
    "ansible_python_interpreter"         = var.ansible_python_interpreter
    "consul_domain"                      = var.consul_domain
    "consul_datacenter"                  = var.vsphere_datacenter
    "consul_group_name"                  = var.consul_group_name
    "consul_group"                       = var.consul_group
    "consul_cloud_autodiscovery"         = var.consul_cloud_autodiscovery
    "consul_cloud_autodiscovery_string"  = local.consul_cloud_autodiscovery_string
    "consul_ports"                       = var.consul_ports
    "consul_src_def"                     = var.consul_src_def
    "consul_tls_src_files"               = var.consul_tls_src_files
    "consul_tls_enable"                  = var.consul_tls_enable
    "consul_tls_ca_crt"                  = var.consul_tls_ca_crt
    // "consul_tls_server_crt"              = var.consul_tls_server_crt
    // "consul_tls_server_key"              = var.consul_tls_server_key
    "consul_tls_verify_incoming"         = var.consul_tls_verify_incoming
    "consul_tls_verify_outgoing"         = var.consul_tls_verify_outgoing
    "consul_tls_verify_server_hostname"  = var.consul_tls_verify_server_hostname
    "consul_node_role"                   = var.consul_node_role
    "consul_raw_key"                     = var.consul_raw_key
    "consul_connect_enabled"             = var.consul_connect_enabled
    "consul_sylog_enable"                = var.consul_sylog_enable
    "consul_acl_enable"                  = var.consul_acl_enable
    "consul_acl_default_policy"          = var.consul_acl_default_policy
    "consul_version"                     = var.consul_version
    "auto_encrypt"                       = var.auto_encrypt
    "nomad_group_name"                   = var.nomad_group_name
    "nomad_group"                        = var.nomad_group
    "nomad_manage_group"                 = var.nomad_manage_group
    "nomad_vault_enabled"                = var.nomad_vault_enabled
    "nomad_vault_address"                = var.nomad_vault_address
    "nomad_vault_create_from_role"       = var.nomad_vault_create_from_role
    "nomad_node_class"                   = var.nomad_node_class
    "nomad_datacenter"                   = var.vsphere_datacenter
    "nomad_leave_on_terminate"           = var.nomad_leave_on_terminate
    "nomad_leave_on_interrupt"           = var.nomad_leave_on_interrupt
    "nomad_version"                      = var.nomad_version
    "nomad_vault_cert_file"              = var.nomad_vault_cert_file
    "nomad_vault_key_file"               = var.nomad_vault_key_file
    "nomad_vault_tls_skip_verify"        = var.nomad_vault_tls_skip_verify
    "nomad_telemetry"                    = var.nomad_telemetry
    "nomad_telemetry_prometheus_metrics" = var.nomad_telemetry_prometheus_metrics
    "nomad_docker_enable"                = var.nomad_docker_enable
    "nomad_options"                      = var.nomad_options
    "nomad_meta"                         = var.nomad_meta
    // The nomad_host_volumes owner and group must match the same uid and gid as specified in provisioned_disks
    // if that is being uses. The ansible nomad role will try to create the directory before configuring it in
    // the client.hcl file.
    "nomad_host_volumes"                  = [
      {
          "name" = "frank-wowza-content"
          "path" = "/mnt/local/wowza_content_s3_mount"
          "owner" = "cicduser"
          "group" = "nomad"
          "mode" = "0777"
          "read_only" = "false"
      }
    ]
    "proxy_env"                          = merge(var.provisioned_disks...)
    "secret_proxy_env"                   = {
      "S3_STREAMING_ACCESS_KEY"          = "${var.S3_STREAMING_ACCESS_KEY}"
      "S3_STREAMING_SECRET_KEY"          = "${var.S3_STREAMING_SECRET_KEY}"
    }
    // TODO: Possible future improvement if we can get the syntax right instead of simply merging all properties for provisioned_disks together (not all needed)
    // "proxy_env"                          = for index, disk in var.provisioned_disks : {
    //   "LABEL_${disk.device_drive}" = "${disk.label}",
    //   "S3_HOST_${index}" = "https://nonprods3fs01.dal.jhdc.local:9000",
    //   "S3_MOUNT_${index}" = "/mnt/local/wowza_video0",
    //   "S3_UID_${index}" = "1000",
    //   "S3_GID_${index}" = "1002",
    //   "S3_ACL_${index}" = "private",
    //   "S3_BUCKET_${index}" = "streaming-wowza-video-test",
    //   "S3_ACCESS_KEY_ID_${index}" = "jWXw7dyp3786g7qEHhC4",
    //   "S3_SECRET_ACCESS_KEY_${index}" = "e2tAVMB4NUkd9cqyTC2kRMGtvVWxcuSgXX",
    //   "S3_NO_CHECK_CERTIFICATE_${index}" = "true",
    //   "S3_SSL_VERIFY_HOSTNAME_${index}" = "0",
    // }
  }
}

# TODO: Add folder resource back in

module "virtual_machines" {
  source  = "app.terraform.io/JohnstonHowse/vm-module/vsphere"
  version = "1.0.14"
  //source  = "git@bitbucket.org:johnstonhowse/terraform-vsphere-vm-module.git"
  count   = tonumber(var.num_instances)
  ### matches count of instances, To use DHCP create Empty list ["",""]

  network = {
    (data.vsphere_network.network.name) = var.ip_address
    ### "Network02" = ["10.13.113.2", "10.13.113.3"] # Second Network will use the static
  }

  network_type = data.vsphere_virtual_machine.template.network_interface_types[0]


  ### Data Disks section

  ### Disks section
  disk_label     = ["${var.name_prefix}-disk0"]            ### disk0
  disk_size_gb   = [var.disk_size[var.resource_pool_type]] ### disk0
  disk_datastore = data.vsphere_datastore.datastore.name   ### disk0
  scsi_type      = "lsilogic"
  //  storage_policy_id = "" # TODO : Target storage policy for placements

  data_disk = {for index, disk in var.provisioned_disks : disk.label => {
      "device_drive" = "${disk.device_drive}"
      "size_gb" = "${var.disk_size[disk.disk_size]}"
      "thin_provisioned" = "${disk.thin_provisioned}"
      "eagerly_scrub" = "${disk.eagerly_scrub}"
      "datastore_id" = "${data.vsphere_datastore.datastore.id}"
      "data_disk_scsi_controller" = "${disk.data_disk_scsi_controller}"
    }
  }

  ###########################################
  vmname = "${var.name_prefix}-${count.index}"
  ### required
  vmtemp     = data.vsphere_virtual_machine.template.name
  instances  = var.num_instances
  // cpu_number = var.num_cores[var.resource_pool_type]
  cpu_number = 8
  // ram_size   = var.mem_size[var.resource_pool_type]
  ram_size   = "64000"
  ### required
  dc = var.vsphere_datacenter
  ### required
  vmrp     = data.vsphere_resource_pool.resource_pool.name
  vmfolder = var.vsphere_folder

  ### Global Customization Variables # TODO : Figure out tagging, think we need to build these first
  //  tags = {
  //    "terraform-test-category"    = "terraform-test-tag"
  //    "consul-client-autodiscover" = "true"
  //  }

  ### Linux Customization Variables
  vmdomain = "local.domain"
  extra_config = {
    "guestinfo.metadata"          = base64encode(file("${path.module}/../configs/ubuntu-server/meta-data"))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(file("${path.module}/../configs/ubuntu-server/user-data"))
    "guestinfo.userdata.encoding" = "base64"
  }

  // wait_for_guest_net_timeout = 0

  //Provisioning configurations
  remote_exec_command      = var.remote_exec_command
  remote_exec_user         = var.remote_exec_user
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  remote_exec_timeout      = var.remote_exec_timeout
  local_exec_user          = var.local_exec_user
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  path_to_ansible          = var.path_to_ansible
  ansible_args             = format("--extra-vars '%#v' -e 'hostname=${var.name_prefix}-${count.index}' -e 'nomad_node_name=${var.name_prefix}-${count.index}' -vvv -b", local.ansible_extra_vars)
}
