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
########## VAULT PROVIDER ##########
variable "vault_server_url" {
  description = "Vault server URL"
  default     = ""
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
variable "nomad_region" {
  description = ""
  type        = string
}
variable "nomad_node_class" {
  description = ""
  type        = string
}
variable "nomad_vault_address" {
  description = ""
  type        = string
}
variable "nomad_vault_tls_skip_verify" {
  description = ""
  type        = string
}
variable "nomad_options" {
  description = ""
  type        = any
}
variable "nomad_meta" {
  description = ""
  type        = any
}
variable "nomad_host_volumes" {
  description = ""
  type        = any
}
variable "nomad_max_kill_timeout" {
  description = ""
  type        = string
}
########## VAULT ##########
variable "vault_agent_role_id" {
  description = ""
  type        = any
  sensitive   = true
}
variable "vault_agent_secret_id" {
  description = ""
  type        = any
  sensitive   = true
}
variable "vault_consul_role_cluster_type" {
  description = ""
  type        = any
}
variable "vault_agent_templates" {
  description = ""
  type        = any
}