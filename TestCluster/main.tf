# TODO: abstract variables - not allowed in this block
terraform {
  backend "remote" {
    #organization = "example-org-186bcc"
    organization = "JohnstonHowse"

    workspaces {
      #name = "jh-test-cli"
      name = "cli-vsphere-testing"
    }
  }
}

# TODO: Implement local copy of module
/*
module "testcluster1" {
  source = "../modules/terraform-vsphere-vm"
  dc = ""
  vmrp = ""
  vmtemp = ""
}
*/

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_pass
  vsphere_server = var.vsphere_server
  # If you have a self-signed cert
  allow_unverified_ssl = true
  client_debug = true
}

data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}
data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}
/*
data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}
data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}
resource "vsphere_virtual_machine" "vm" {
  name             = "terraform-base1"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = 2
  memory   = 1024
  guest_id = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
}
resource "vsphere_virtual_machine" "vm2" {
  name             = "terraform-base2"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  num_cpus = 2
  memory   = 1024
  guest_id = "other3xLinux64Guest"
  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 20
  }
}
*/
