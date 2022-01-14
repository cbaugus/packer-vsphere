#Performance replication cluster A
module "vault_cluster" {
  source  = "app.terraform.io/JohnstonHowse/cluster-module/vsphere"
  version = "0.3.0"

  #Cluster vars
  num_instances    = 1
  cores_count_type = "medium"
  mem_size_type    = "medium"
  disk_size_type   = "medium"
  name_prefix      = var.name_prefix

  #vSphere required inputs
  vsphere_compute_cluster = var.vsphere_compute_cluster
  vsphere_resource_pool   = var.vsphere_resource_pool
  vsphere_datastore       = var.vsphere_datastore
  vsphere_network         = var.vsphere_network
  vsphere_folder          = var.vsphere_folder
  vsphere_template        = var.vsphere_template
  vsphere_user            = var.vsphere_user
  vsphere_pass            = var.vsphere_pass

  #Terraform Provisioner required inputs
  path_to_ansible          = "../../ansible-deployments/vault-server.yml"
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user
}