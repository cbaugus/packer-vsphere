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
  description = "vSphere compute cluser"
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
  type = string
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
    small = 35
    medium = 70
    large = 120
  }
}
variable "mem_size" {
  description = "Amount of memory to be applied to VM(s)"
  default = {
    small = "1024"
    medium = "2048"
    large  = "4096"
  }
}
variable "ip_addresses" {
  description = "IP addresses of VMs to create, empty string for DHCP"
  type = list(string)
  default = null
}
variable "remote_exec_command" {
  description = "Command for remote exec provisioner to run"
  type = string
  default = "echo Running the remote-exec provisioner"
}
variable "remote_exec_user" {
  description = "User for remote exec provisioner to connect as"
  type = string
  default = "cicduser"
}
variable "remote_exec_ssh_key_file" {
  description = "Path to the SSH key to connect to created VMs, located on the Terraform runner"
  type        = string
  default     = "/opt/devops-local/ssl/keys/key.pem"
}
variable "remote_exec_timeout" {
  description = "Timeout value for remote exec provisioner to conenct to VM"
  type = string
  default = "1m"
}
variable "local_exec_user" {
  description = "User for local exec provisioner to connect as with Ansible"
  type        = string
  default = "cicduser"
}
variable "local_exec_ssh_key_file" {
  description = "Path to the SSH key to connect to created VMs, located on the Terraform runner"
  type        = string
  default     = "/opt/devops-local/ssl/keys/key.pem"
}
variable "path_to_ansible" {
  description = "Location of Ansible playook on Terraform runner"
  type = string
  default = "../../ansible-deployments/main.yml"
}
#TODO: Create map with arguments corresponding to VM template being used
variable "ansible_arguments" {
  description = "Arguments to be passed to Ansible playbook run"
  type = string
  default = "-e ansible_python_interpreter=/usr/bin/python3.8 -vvv -b"
  #default = "-e 'ansible_python_interpreter=/usr/bin/python3.8' -vvv -b" #Ubuntu
  #ansible_args = "-e 'ansible_python_interpreter=/usr/bin/python3.9' -vvv" #Photon
}