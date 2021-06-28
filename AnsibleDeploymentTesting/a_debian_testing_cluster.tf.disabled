module "debian_testing_cluster" {
  source = "../modules/terraform-vsphere-vm"
  ### matches count of instances, To use DHCP create Empty list ["",""]
  network = {
    (data.vsphere_network.network.name) = [
      ""
    ]
  }
  ### matches count of instances
  network_type = [
    data.vsphere_virtual_machine.template_debian.network_interface_types[0]
  ]

  ### Data Disks section

  ### Disks section
  disk_label     = ["${var.name_prefix}-debian-disk0"]      ### disk0
  disk_size_gb   = ["35"]                                ### disk0
  disk_datastore = data.vsphere_datastore.datastore.name ### disk0
  scsi_type      = "lsilogic"
  //  storage_policy_id = "" # TODO : Target storage policy for placements

  ###########################################
  vmname = "${var.name_prefix}-debian-"
  //  vmnamesuffix = ""
  //  vmnameliteral = ""
  ### required
  vmtemp     = data.vsphere_virtual_machine.template_debian.name
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
  ### NOTE: Linux customization for Debian not supported by VMware
  // vmdomain = "local.domain"
}
