module "example_cluster" {
  source = "./modules/terraform-vsphere-vm"
  ### matches count of instances, To use DHCP create Empty list ["",""]
  network = {
    (data.vsphere_network.network.name) = [
      "",
      ""
    ]
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
  disk_size_gb   = ["35"]                                ### disk0
  disk_datastore = data.vsphere_datastore.datastore.name ### disk0
  scsi_type      = "lsilogic"
  //  storage_policy_id = "" # TODO : Target storage policy for placements

  ###########################################
  vmname = "${var.name_prefix}-dlg"
  //  vmnamesuffix = ""
  //  vmnameliteral = ""
  ### required
  vmtemp     = data.vsphere_virtual_machine.template.name
  instances  = "2"
  cpu_number = "2"
  ram_size   = "1024"
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
  remote_exec_command = "echo Running the remote-exec provisioner"
  remote_exec_user = "cicduser"
  remote_exec_ssh_key_file = "/opt/devops-local/ssl/keys/key.pem"
  remote_exec_timeout = "1m"
  local_exec_user = "cicduser"
  local_exec_ssh_key_file = "/opt/devops-local/ssl/keys/key.pem"
  path_to_ansible = ""
  ansible_args = "-e 'ansible_python_interpreter=/usr/bin/python3.8' -vvv"
  #local_exec_command = "ansible-playbook -u cicduser -i '${self.default_ip_address},' --private-key ~/.ssh/keys/key.pem ${path.root}/../../ansible-deployments/main.yml -b"
}
