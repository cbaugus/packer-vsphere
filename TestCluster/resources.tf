resource "vsphere_virtual_machine" "vm" {
  count            = 3
  name             = "terraform-base-${count.index}"
  resource_pool_id = data.vsphere_compute_cluster.compute_cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = 2
  memory   = 1024
  guest_id = data.vsphere_virtual_machine.template.guest_id
  folder = var.vsphere_folder
  network_interface {
    network_id = data.vsphere_network.network.id
    adapter_type = data.vsphere_virtual_machine.template.network_interface_types[0]
  }
  disk {
    label = "disk0"
    size  = 20
  }
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id

    customize {
      linux_options {
        host_name = "terraform-base-${count.index}"
        domain    = "local.domain"
      }

      network_interface {}
    }
  }
}
