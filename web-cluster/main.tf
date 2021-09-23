module "cluster" {
  source  = "app.terraform.io/JohnstonHowse/cluster-module/vsphere"
  version = "0.0.20"

  #Cluster vars
  num_instances      = var.num_instances
  resource_pool_type = var.resource_pool_type
  name_prefix        = "${var.name}-${var.resource_pool_type}"

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
  path_to_ansible          = "../../ansible-deployments/cluster-bootstrap.yml"
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user

  #S3/Growr overrides
  provisioned_disks = var.provisioned_disks

  #Consul overrides
  consul_pass    = var.consul_pass
  consul_raw_key = var.consul_raw_key
  consul_iptables_enable = "false"

  #Nomad overrides
  nomad_region                = var.nomad_region
  nomad_node_class            = var.nomad_node_class
  nomad_vault_address         = var.nomad_vault_address
  nomad_vault_tls_skip_verify = var.nomad_vault_tls_skip_verify
  nomad_options               = var.nomad_options
  nomad_meta                  = var.nomad_meta
  nomad_host_volumes          = var.nomad_host_volumes

  #Vault overrides
  vault_agent_role_id            = var.vault_agent_role_id
  vault_agent_secret_id          = var.vault_agent_secret_id
  vault_consul_role_cluster_type = var.vault_consul_role_cluster_type
  vault_agent_templates          = var.vault_agent_templates
}