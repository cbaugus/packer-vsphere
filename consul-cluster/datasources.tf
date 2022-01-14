data "vsphere_tag_category" "vm_tags" {
  name = "hashistack"
}

data "vsphere_tag" "consul" {
  name        = var.name
  category_id = data.vsphere_tag_category.vm_tags.id
}