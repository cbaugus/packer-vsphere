
vsphere_datacenter = "dal-w01-dc01"
vsphere_datastore = "dal-w01-cl01-ds-vsan01"

virtual_disks = {
  wowza_content = {
    virtual_disk_type = "small"
    vmdk_path = "wowza-disks/wowza-content.vmdk"
    disk_type = "thin"
  }
  wowza_logs = {
    virtual_disk_type = "small"
    vmdk_path = "wowza-disks/wowza-logs.vmdk"
    disk_type = "thin"
  }
  wowza_video = {
    virtual_disk_type = "small"
    vmdk_path = "wowza-disks/wowza-video.vmdk"
    disk_type = "thin"
  }
}
