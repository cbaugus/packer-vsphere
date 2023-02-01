module "cluster" {
  source  = "app.terraform.io/baugus-lab/cluster-module/vsphere"
  version = "v1.0.6"

  #Cluster vars
  num_instances      = var.num_instances
  cores_count_type = var.resource_pool_type
  mem_size_type    = var.resource_pool_type
  disk_size_type   = "medium"
  name_prefix        = "${var.name}-${var.env}"
  #nomad_node_class            = var.env

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
  path_to_ansible          = var.path_to_ansible
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user

  #S3/Growr overrides
  provisioned_disks    = var.provisioned_disks
  growr_provisioned_disks = local.growr_provisioned_disks


  #Known Hosts
  known_hosts_targets            = local.known_hosts_targets
  known_hosts_user               = local.known_hosts_user
}
