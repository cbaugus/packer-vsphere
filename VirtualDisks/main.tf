
// Folder path must exist on the vsan beforehand, vmdk cannot be at root level, must be within a folder
resource "vsphere_virtual_disk" "virtual_disks" {
  for_each = var.virtual_disks

  size       = var.num_gbs[each.value.virtual_disk_type]
  vmdk_path  = each.value.vmdk_path
  datacenter = var.vsphere_datacenter
  datastore  = var.vsphere_datastore
  type       = each.value.disk_type
}
