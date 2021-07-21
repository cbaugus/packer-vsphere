locals {
  ansible_extra_vars = {
    "ansible_python_interpreter"        = var.ansible_python_interpreter
    "consul_domain"                     = var.consul_domain
    "consul_datacenter"                 = "${var.vsphere_datacenter}"
    "consul_group_name"                 = var.consul_group_name
    "consul_group"                      = var.consul_group_name
    "consul_cloud_autodiscovery"        = var.consul_cloud_autodiscovery
    "consul_cloud_autodiscovery_string" = "provider=vsphere category_name=vmTags tag_name=consul host=${var.vsphere_server} user=${var.vsphere_user} password=${var.vsphere_pass} insecure_ssl=true timeout=2m"
    "consul_ports"                      = { "grpc" = "8502", "dns" = "8600", "http" = "8500", "https" = "-1", "rpc" = "8400", "serf_lan" = "8301", "serf_wan" = "8302", "server" = "8300" }
    "consul_src_def"                    = var.consul_src_def
    "consul_tls_src_files"              = "/tmp"
    "consul_tls_enable"                 = "True"
    "consul_tls_ca_crt"                 = "consul-agent-ca.pem"
    "consul_tls_verify_incoming"        = "False"
    "consul_tls_verify_outgoing"        = "True"
    "consul_tls_verify_server_hostname" = "False"
    "consul_node_role"                  = "client"
    "consul_raw_key"                    = "${var.consul_raw_key}"
    "consul_connect_enabled"            = "True"
    "consul_sylog_enable"               = "True"
    "auto_encrypt"                      = { "enabled" = "True" }
    "nomad_group_name"                  = "all"
    "nomad_group"                       = "bin"
    "nomad_vault_enabled"               = "yes"
    "nomad_vault_address"               = "https://vault.service.consul:8200"
    "nomad_vault_create_from_role"      = "nomad-cluster"
    "nomad_node_class"                  = "production"
    "nomad_datacenter"                  = "${var.vsphere_datacenter}"
    "nomad_version"                     = "1.1.2"
    "nomad_vault_enabled"               = "True"
    "nomad_vault_address"               = "https://vault.service.consul:8200"
    "nomad_vault_create_from_role"      = "nomad-cluster"
    "nomad_vault_cert_file"             = "/opt/vault/tls/tls.crt"
    "nomad_vault_key_file"              = "/opt/vault/tls/tls.key"
    "nomad_vault_tls_skip_verify"       = "True"
    "nomad_options" = {
      "driver.raw_exec.enable" = "1"
      "driver.java.enable"     = "0"
      "docker.cleanup.image"   = "false"
      "docker.volumes.enabled" = "true"
    }
    "nomad_meta" = {
      "node-switcher" = "on"
      "system-fab-lb" = "on"
      "purpose"       = "operations"
    }
  }
}

module "jenkins_workers" {
  source  = "app.terraform.io/JohnstonHowse/vm-module/vsphere"
  version = "1.0.9"
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

  ###########################################
  vmname = "${var.name_prefix}-${count.index}"
  ### required
  vmtemp     = data.vsphere_virtual_machine.template.name
  instances  = var.num_instances
  cpu_number = var.num_cores[var.resource_pool_type]
  ram_size   = var.mem_size[var.resource_pool_type]
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
