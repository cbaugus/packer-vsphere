data "vsphere_tag_category" "vm_tags" {
  name = "hashistack"
}

data "vsphere_tag" "nomad" {
  name        = var.name
  category_id = data.vsphere_tag_category.vm_tags.id
}