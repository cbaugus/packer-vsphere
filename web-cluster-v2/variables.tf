########## CLUSTER ##########
variable "num_instances" {
  description = "Number of VMs to be provisioned in cluster"
  type        = string
}
variable "resource_pool_type" {
  description = "Small, medium, large, or xl"
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
########## TERRAFORM ##########
variable "local_exec_ssh_key_file" {
  description = ""
  type        = string
}
variable "local_exec_user" {
  description = ""
  type        = string
  sensitive   = true
}

########## ANSIBLE ##########
variable "path_to_ansible" {
  description = ""
  type        = any
}
variable "remote_exec_ssh_key_file" {
  description = ""
  type        = any
}
variable "remote_exec_user" {
  description = ""
  type        = any
}

########## GROWR ##########
variable "provisioned_disks" {
  description = ""
  type        = any
}

########## NFS ##########
variable "nfs_mount_server" {
  description = ""
  type        = any
}
variable "nfs_mount_options" {
  description = ""
  type        = any
}
variable "nfs_mount_path" {
  description = ""
  type        = any
}

