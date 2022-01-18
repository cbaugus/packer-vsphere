########## VSPHERE PROVIDER ##########
variable "name" {
  description = "Prefixed name of VM"
  type        = string
}
variable "num_instances" {
  type = number
}
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
variable "vsphere_datacenter" {
  description = "vSphere datacenter"
  type        = string
}
variable "vsphere_server" {
  description = "vSphere server address"
  type        = string
}
variable "vsphere_compute_cluster" {
  description = "vSphere compute cluster"
  type        = string
}
variable "vsphere_resource_pool" {
  description = ""
  type        = string
}
variable "vsphere_datastore" {
  description = ""
  type        = string
}
variable "vsphere_network" {
  description = ""
  type        = string
}
variable "vsphere_folder" {
  description = ""
  type        = string
}
variable "vsphere_template" {
  description = ""
  type        = string
}
variable "remote_exec_ssh_key_file" {
  description = ""
  type        = string
}
variable "local_exec_ssh_key_file" {
  description = ""
  type        = string
}
variable "local_exec_user" {
  description = ""
  type        = string
  sensitive   = true
}
########## NOMAD SERVER PROVISIONER ##########
variable "nomad_region" {
  description = ""
  type        = string
}