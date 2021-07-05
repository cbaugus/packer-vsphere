module "jenkins_workers" {
  source = "app.terraform.io/JohnstonHowse/vm-module/vsphere"
  version = "1.0.0"
  ### matches count of instances, To use DHCP create Empty list ["",""]
  network = {
    (data.vsphere_network.network.name) = var.ip_addresses
    ### "Network02" = ["10.13.113.2", "10.13.113.3"] # Second Network will use the static
  }
  ### matches count of instances
  network_type = [
    data.vsphere_virtual_machine.template.network_interface_types[0],
    data.vsphere_virtual_machine.template.network_interface_types[0]
  ]

  ### Data Disks section

  ### Disks section
  disk_label     = ["${var.name_prefix}-dlg-disk0"]      ### disk0
  disk_size_gb   = [var.disk_size[var.resource_pool_type]]                                ### disk0
  disk_datastore = data.vsphere_datastore.datastore.name ### disk0
  scsi_type      = "lsilogic"
  //  storage_policy_id = "" # TODO : Target storage policy for placements

  ###########################################
  vmname = "${var.name_prefix}-dlg"
  //  vmnamesuffix = ""
  //  vmnameliteral = ""
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
  remote_exec_command = var.remote_exec_command
  remote_exec_user = var.remote_exec_user
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  remote_exec_timeout = var.remote_exec_timeout
  local_exec_user = var.local_exec_user
  local_exec_ssh_key_file = var.local_exec_ssh_key_file
  path_to_ansible = var.path_to_ansible
  ansible_args = var.ansible_arguments
}
