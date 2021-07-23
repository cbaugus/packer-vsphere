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
    small  = "2048"
    medium = "4096"
    large  = "8192"
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
variable "consul_user" {
  description = "vSphere Consul username"
  type        = string
  sensitive   = true
}
variable "consul_pass" {
  description = "vSphere Consul password"
  type        = string
  sensitive   = true
}
variable "consul_raw_key" {
  description = "Consul gossip key"
  type        = string
  sensitive   = true
}
variable "consul_tls_enable" {
  description = "Consul gossip key"
  type        = string
  sensitive   = true
  default     = "True"
}
variable "consul_tls_ca_crt" {
  description = "Consul CA certificate file name"
  type        = string
  sensitive   = true
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
  default     = "/root/.ssh"
}
variable "consul_tls_src_files" {
  description = ""
  type        = string
  default     = "/root/.ssh"
}
variable "consul_tls_verify_incoming" {
  description = ""
  type        = string
  default     = "False"
}
variable "consul_tls_verify_outgoing" {
  description = ""
  type        = string
  default     = "True"
}
variable "consul_tls_verify_server_hostname" {
  description = ""
  type        = string
  default     = "False"
}
variable "consul_node_role" {
  description = ""
  type        = string
  default     = "client"
}
variable "consul_connect_enabled" {
  description = ""
  type        = string
  default     = "True"
}
variable "consul_sylog_enable" {
  description = ""
  type        = string
  default     = "True"
}
variable "consul_acl_enable" {
  description = ""
  type        = string
  default     = "True"
}
variable "consul_acl_default_policy" {
  description = ""
  type        = string
  default     = "allow"
}
variable "consul_version" {
  description = ""
  type        = string
  default     = "1.9.4"
}
variable "auto_encrypt" {
  description = ""
  type        = map(any)
  default     = { "enabled" = "True" }
}
variable "consul_ports" {
  description = ""
  type        = map(any)
  default     = { "grpc" = "8502", "dns" = "8600", "http" = "8500", "https" = "-1", "rpc" = "8400", "serf_lan" = "8301", "serf_wan" = "8302", "server" = "8300" }
}
variable "nomad_group_name" {
  description = ""
  type        = string
  default     = "all"
}
variable "nomad_group" {
  description = ""
  type        = string
  default     = "bin"
}
variable "nomad_vault_enabled" {
  description = ""
  type        = string
  default     = "yes"
}
variable "nomad_vault_address" {
  description = ""
  type        = string
  default     = "https://vault.service.consul:8200"
}
variable "nomad_vault_create_from_role" {
  description = ""
  type        = string
  default     = "nomad-cluster"
}
variable "nomad_node_class" {
  description = ""
  type        = string
  default     = "production"
}
variable "nomad_leave_on_terminate" {
  description = ""
  type        = string
  default     = "yes"
}
variable "nomad_leave_on_interrupt" {
  description = ""
  type        = string
  default     = "yes"
}
variable "nomad_version" {
  description = ""
  type        = string
  default     = "1.1.2"
}
variable "nomad_vault_cert_file" {
  description = ""
  type        = string
  default     = "/opt/vault/tls/tls.crt"
}
variable "nomad_vault_key_file" {
  description = ""
  type        = string
  default     = "/opt/vault/tls/tls.key"
}
variable "nomad_vault_tls_skip_verify" {
  description = ""
  type        = string
  default     = "True"
}
variable "nomad_options" {
  description = ""
  type        = map(any)
  default = {
    "driver.raw_exec.enable" = "1"
    "driver.java.enable"     = "0"
    "docker.cleanup.image"   = "false"
    "docker.volumes.enabled" = "true"
  }
}
variable "nomad_meta" {
  description = ""
  type        = map(any)
  default = {
    "node-switcher" = "on"
    "system-fab-lb" = "on"
    "purpose"       = "operations"
  }
}
