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
//variable "sub_envs" {
//  description = ""
//  type        = map(string)
//}
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
variable "vsphere_template" {
  description = ""
  type        = string
}
########## VAULT PROVIDER ##########
variable "vault_server_url" {
  description = "Vault server URL"
  sensitive   = true
}
variable "vault_approle_id" {
  description = "Vault server app role ID"
  default     = ""
  sensitive   = true
}
variable "vault_approle_secret_id" {
  description = "Vault server app role secret"
  default     = ""
  sensitive   = true
}
########## CONSUL PROVIDER ##########
variable "consul_provider_token" {
  description = "Token with which to authenticate to Consul"
  sensitive   = true
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
########## GROWR ##########
variable "provisioned_disks" {
  description = ""
  type        = any
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
variable "consul_acl_token" {
  description = ""
  type        = string
  sensitive   = true
}
########## NOMAD ##########
variable "nomad_vault_tls_skip_verify" {
  description = ""
  type        = string
}
variable "nomad_options" {
  description = ""
  type        = any
}
variable "nomad_plugins" {
  description = ""
  type        = any
  default     = {}
}
########## DOCKER ##########
variable "docker_vault_login" {
  description = ""
  type        = any
  default     = {}
}
########## VAULT ##########
variable "vault_agent_role_id" {
  description = ""
  type        = string
  sensitive   = true
}
variable "vault_agent_secret_id" {
  description = ""
  type        = string
  sensitive   = true
}
variable "vault_docker_secrets" {
  description = ""
  type        = any
}

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