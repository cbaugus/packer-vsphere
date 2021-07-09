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
variable "vsphere_template_ubuntu" {
  description = "vSphere template for creating VM (Ubuntu)"
  type        = string
}
variable "vsphere_template_debian" {
  description = "vSphere template for creating VM (Debian)"
  type        = string
}
variable "vsphere_template_centos" {
  description = "vSphere template for creating VM (CentOS)"
  type        = string
}
variable "vsphere_template_photon" {
  description = "vSphere template for creating VM (Photon OS)"
  type        = string
}
variable "name_prefix" {
  description = "Prefix for naming convention of VMs"
  type        = string
}
variable "consul_user" {
  description = "vSphere consul username"
  type        = string
  sensitive   = true
}
variable "consul_pass" {
  description = "vSphere consul  password"
  type        = string
  sensitive   = true
}
variable "consul_raw_key" {
  description = "Consul gossip key"
  type        = string
  sensitive   = true
}
variable "num_instances" {
  description = "Number of VMs to provision"
  type        = string
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