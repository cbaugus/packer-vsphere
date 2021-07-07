locals {
  ansible_extra_vars = {
	"ansible_python_interpreter"          = "/usr/bin/python3"
  	"hostname"                            = "ansible-deployment-testing-ubuntu-1"
  	"consul_domain"                       = "consul."
  	"consul_datacenter"                   = "${var.vsphere_datacenter}"
  	"consul_group_name"                   = "all"
  	"consul_group"                        = "consul_instances"
  	"consul_cloud_autodiscovery"          = "true"
  	"consul_cloud_autodiscovery_string"   = "provider=vsphere category_name=vmTags tag_name=consul host=${var.vsphere_server} user=${var.vsphere_user} password=${var.vsphere_pass} insecure_ssl=true timeout=2m"
  	"consul_src_def"                      = "/opt/devops-local/ssl/certs"
  	"consul_tls_src_files"                = "/opt/devops-local/ssl/certs"
  	"consul_tls_enable"                   = "true"
  	"consul_tls_ca_crt"                   = "consul-agent-ca.pem"
  	"consul_tls_server_crt"               = "dc1-server-consul-0.pem"
  	"consul_tls_server_key"               = "dc1-server-consul-0-key.pem"
  	"consul_tls_verify_incoming"          = "true"
  	"consul_tls_verify_outgoing"          = "true"
  	"consul_tls_verify_server_hostname"   = "false"
  	"consul_raw_key"                      = "${var.consul_raw_key}"
  	"consul_connect_enabled"              = "true"
  	"auto_encrypt"                        = { "enabled" = "true" }
  	"vault_backend"                       = "consul"
  	"vault_service_restart"               = "false"
  	"nomad_group_name"                    = "all"
  	"nomad_group"                         = "bin"
	"nomad_vault_enabled"                 = "yes"
	"nomad_vault_address"                 = "https://vault.service.consul:8200"
        "nomad_vault_create_from_role"        = "nomad-cluster"
	"nomad_node_name"                     = "ansible-deployment-testing-ubuntu-1"
	"nomad_node_class"                    = "production"
	"nomad_datacenter"                    = "${var.vsphere_datacenter}"
  } 
}

module "ubuntu_testing_cluster" {
  source = "app.terraform.io/JohnstonHowse/vm-module/vsphere"
  version = "1.0.0"
  
  ### matches count of instances, To use DHCP create Empty list ["",""]
  network = {
    (data.vsphere_network.network.name) = [
      ""
    ]
  }
  ### matches count of instances
  network_type = [
    data.vsphere_virtual_machine.template_ubuntu.network_interface_types[0]
  ]

  ### Data Disks section

  ### Disks section
  disk_label     = ["${var.name_prefix}-ubuntu-disk0"]      ### disk0
  disk_size_gb   = ["35"]                                ### disk0
  disk_datastore = data.vsphere_datastore.datastore.name ### disk0
  scsi_type      = "lsilogic"
  //  storage_policy_id = "" # TODO : Target storage policy for placements

  ###########################################
  vmname = "${var.name_prefix}-ubuntu-"
  //  vmnamesuffix = ""
  //  vmnameliteral = ""
  ### required
  vmtemp     = data.vsphere_virtual_machine.template_ubuntu.name
  instances  = "1"
  cpu_number = "2"
  ram_size   = "1024"
  ### required
  dc         = var.vsphere_datacenter
  ### required
  vmrp       = data.vsphere_resource_pool.resource_pool.name
  vmfolder   = var.vsphere_folder

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

  ### Provisioning configurations
  remote_exec_command = "echo Running the remote-exec provisioner"
  remote_exec_user = "cicduser"
  remote_exec_ssh_key_file = "/opt/devops-local/ssl/keys/key.pem"
  remote_exec_timeout = "1m"
  local_exec_user = "cicduser"
  local_exec_ssh_key_file = "/opt/devops-local/ssl/keys/key.pem"
  path_to_ansible = "../../ansible-deployments/main.yml"
  ansible_args = format("-e '%#v' -vvv -b", local.ansible_extra_vars) 

}
