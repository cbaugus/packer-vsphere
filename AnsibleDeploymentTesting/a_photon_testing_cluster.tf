module "photon_testing_cluster" {
  source = "../modules/terraform-vsphere-vm"
  ### matches count of instances, To use DHCP create Empty list ["",""]
  network = {
    (data.vsphere_network.network.name) = [
      ""
    ]
  }
  ### matches count of instances
  network_type = [
    data.vsphere_virtual_machine.template_photon.network_interface_types[0]
  ]

  ### Data Disks section

  ### Disks section
  disk_label     = ["${var.name_prefix}-photon-disk0"]      ### disk0
  disk_size_gb   = ["35"]                                ### disk0
  disk_datastore = data.vsphere_datastore.datastore.name ### disk0
  scsi_type      = "lsilogic"
  //  storage_policy_id = "" # TODO : Target storage policy for placements

  ###########################################
  vmname = "${var.name_prefix}-photon-"
  //  vmnamesuffix = ""
  //  vmnameliteral = ""
  ### required
  vmtemp     = data.vsphere_virtual_machine.template_photon.name
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
    "guestinfo.metadata"          = base64encode(file("${path.module}/../configs/photon-server/meta-data"))
    "guestinfo.metadata.encoding" = "base64"
    "guestinfo.userdata"          = base64encode(file("${path.module}/../configs/photon-server/user-data"))
    "guestinfo.userdata.encoding" = "base64"
  }

  //Provisioning configurations
  remote_exec_command = "echo Running the remote-exec provisioner"
  remote_exec_user = "cicduser"
  remote_exec_ssh_key_file = "/opt/devops-local/ssl/keys/key.pem"
  remote_exec_timeout = "1m"
  local_exec_user = "cicduser"
  local_exec_ssh_key_file = "/opt/devops-local/ssl/keys/key.pem"
  path_to_ansible = "../../ansible-deployments/main.yml"
  ansible_args = "-e 'ansible_python_interpreter=/usr/bin/python3.9 hostname=ansible-deployment-testing-photon-1 consul_group_name=all consul_group=consul_instances' -vvv -b" #Photon


}
