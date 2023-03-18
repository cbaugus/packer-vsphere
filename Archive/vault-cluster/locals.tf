locals {
  vault_raft_cloud_auto_join = "provider=vsphere category_name=hashistack tag_name=${var.name} host=${var.vsphere_server} user=${var.vsphere_user} password=${var.vsphere_pass} insecure_ssl=true timeout=2m"
}
