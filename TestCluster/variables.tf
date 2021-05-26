variable "vsphere_user" {
  description = "vSphere administrator username"
  type        = string
  sensitive   = true
}
variable "vsphere_pass" {
  description = "vSphere administrator password"
  type        = string
  sensitive   = true
}
variable "vsphere_server" {
  description = "vSphere server address"
  type        = string
  sensitive   = true
}
variable "vsphere_datacenter" {
  description = "vSphere datacenter"
  type        = string
}
variable "vsphere_datastore" {
  description = "vSphere datastore"
  type        = string
}
variable "vsphere_resource_pool" {
  description = "vSphere resource pool"
  type        = string
}
variable "vsphere_network" {
  description = "vSphere network"
  type        = string
}
variable "vsphere_folder" {
  description = "vSphere folder"
  type        = string
}
variable "vsphere_template" {
  description = "vSphere template for creating VM"
  type        = string
}
