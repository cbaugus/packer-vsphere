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
variable "vsphere_compute_cluster" {
  description = "vSphere compute cluster"
  type        = string
}
variable "vsphere_resource_pool" {
  description = "vSphere resource pool"
  type        = string
}
variable "vsphere_datastore" {
  description = "vSphere datastore"
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
variable "name_prefix" {
  description = "Prefix for naming convention of VMs"
  type        = string
}
variable "resource_pool_type" {
  description = "Small, medium, or large resource pool."
  type        = string
  validation {
    condition     = var.resource_pool_type == "small" || var.resource_pool_type == "medium" || var.resource_pool_type == "large"
    error_message = "Resource pool type must be small, medium or large."
  }
}
variable "num_cores" {
  description = "Number of CPUs for VMs in cluster"
  default = {
    small  = 2
    medium = 4
    large  = 8
  }
}
variable "num_instances" {
  description = "Number of VMs to provision"
  type        = string
}
variable "disk_size" {
  description = "Size of drive (GB) to be applied to VM(s)"
  default = {
    small  = 35
    medium = 70
    large  = 120
  }
}
variable "mem_size" {
  description = "Amount of memory to be applied to VM(s)"
  default = {
    small  = "1024"
    medium = "2048"
    large  = "4096"
  }
}
variable "ip_address" {
  description = "IP address to use on one network"
  type        = string
  default     = ""
}
variable "ip_addresses" {
  description = "IP addresses of VMs to create, empty string for DHCP"
  type        = list(string)
  default     = null
}
variable "remote_exec_command" {
  description = "Command for remote exec provisioner to run"
  type        = string
  default     = "echo Running the remote-exec provisioner"
}
variable "remote_exec_user" {
  description = "User for remote exec provisioner to connect as"
  type        = string
  default     = "cicduser"
}
variable "remote_exec_ssh_key_file" {
  description = "Path to the SSH key to connect to created VMs, located on the Terraform runner"
  type        = string
}
variable "remote_exec_timeout" {
  description = "Timeout value for remote exec provisioner to connect to VM"
  type        = string
  default     = "1m"
}
variable "local_exec_user" {
  description = "User for local exec provisioner to connect as with Ansible"
  type        = string
  default     = "cicduser"
}
variable "local_exec_ssh_key_file" {
  description = "Path to the SSH key to connect to created VMs, located on the Terraform runner"
  type        = string
}
variable "path_to_ansible" {
  description = "Location of Ansible playbook on Terraform runner"
  type        = string
  default     = "../../ansible-deployments/main.yml"
}
variable "consul_user" {
  description = "vSphere Consul username"
  type        = string
  sensitive   = false
}
variable "consul_pass" {
  description = "vSphere Consul password"
  type        = string
  sensitive   = false
}
variable "consul_raw_key" {
  description = "Consul gossip key"
  type        = string
  sensitive   = false
}
variable "provisioner_hostname_flag" {
  description = "Flag to indicate if the two variables hostname and nomad_node_name should be supplied to the local-exec provisioner with the VM name"
  type        = string
  default     = "true"

  validation {
    condition     = var.provisioner_hostname_flag == "true" || var.provisioner_hostname_flag == "false"
    error_message = "Variable provisioner_hostname_flag must be true or false."
  }
}
variable "ansible_python_interpreter" {
  description = "Python interpreter to be used on target machine"
  type        = string
  default     = "/usr/bin/python3"
}
variable "consul_domain" {
  description = "Domain for Consul DNS"
  type        = string
  default     = "consul."
}
variable "consul_group_name" {
  description = "Group name for Consul"
  type        = string
  default     = "all"
}
variable "consul_group" {
  description = "Group for Consul"
  type        = string
  default     = "consul_instances"
}
variable "consul_cloud_autodiscovery" {
  description = "Consul cloud auto discovery enabled/disabled flag"
  type        = string
  default     = "False"
}
variable "consul_src_def" {
  description = ""
  type        = string
  default     = "/tmp"
}
variable "consul_tls_src_files" {
  description = ""
  type        = string
  default     = "/tmp"
}

