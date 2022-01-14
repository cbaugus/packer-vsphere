########## CLUSTER ##########
variable "num_instances" {
  description = "Number of VMs to be provisioned in cluster"
  type        = string
}
variable "name" {
  description = ""
  type        = string
}
variable "env" {
  description = ""
  type        = string
}
########## VSPHERE PROVIDER ##########
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
}
variable "vsphere_compute_cluster" {
  description = "vSphere compute cluster"
  type        = string
}
variable "vsphere_datacenter" {
  description = "vSphere datacenter"
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
variable "vsphere_template" {
  description = ""
  type        = string
}
########## TERRAFORM ##########
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
########## CONSUL ##########
variable "consul_pass" {
  description = ""
  type        = string
  sensitive   = true
}
variable "consul_raw_key" {
  description = ""
  type        = string
  sensitive   = true
}
variable "consul_acl_replication_token" {
  type      = string
  sensitive = true
  default   = ""
}
variable "consul_acl_agent_token" {
  type      = string
  sensitive = true
  default   = ""
}
