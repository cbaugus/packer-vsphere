provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_pass
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
  client_debug         = true
}

#The token used to authenticate to Consul must have permissions sufficient enough to read ACLs
provider "consul" {
  datacenter = var.vsphere_datacenter
  address    = "http://consul.service.${var.vsphere_datacenter}.consul:8500"
  token      = var.consul_provider_token
}
