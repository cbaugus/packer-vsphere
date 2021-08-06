
######################### Vsphere Module Vars #########################
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

######################### Generalized Vars #########################
variable "virtual_disks" {
  description = "Map of disks to be created"
  type        = map(map(string))
  default     = {}
}

variable "num_gbs" {
  description = "Number of GBs for the virtual disk"
  default = {
    small  = 128
    medium = 256
    large  = 512
  }
}
