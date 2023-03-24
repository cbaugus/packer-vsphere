#Performance replication cluster A
module "vault_cluster" {
  source  = "app.terraform.io/JohnstonHowse/cluster-module/vsphere"
  version = "0.3.7"
  // Uncomment this line for local development with cluster module
  //source = "../../terraform-vsphere-cluster-module"

  #Cluster vars
  num_instances    = var.num_instances
  cores_count_type = "medium"
  mem_size_type    = "medium"
  disk_size_type   = "medium"
  name_prefix      = var.name

  #vSphere required inputs
  vsphere_server          = var.vsphere_server
  vsphere_compute_cluster = var.vsphere_compute_cluster
  vsphere_resource_pool   = var.vsphere_resource_pool
  vsphere_datacenter      = var.vsphere_datacenter
  vsphere_datastore       = var.vsphere_datastore
  vsphere_network         = var.vsphere_network
  vsphere_folder          = var.vsphere_folder
  vsphere_template        = var.vsphere_template
  vsphere_user            = var.vsphere_user
  vsphere_pass            = var.vsphere_pass
  vsphere_tag_ids         = [data.vsphere_tag.vault.id]

  #Terraform Provisioner required inputs
  path_to_ansible          = "../../ansible-deployments/vault-server.yml"
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user

  #Vault server Ansible vars
  vault_version                            = "1.9.2"
  vault_enterprise                         = "false"
  vault_harden_file_perms                  = "true"
  vault_datacenter                         = var.vsphere_datacenter
  vault_cluster_name                       = var.vault_cluster_name
  vault_address                            = "0.0.0.0"
  vault_iface                              = "ens192"
  vault_api_addr                           = "{{ vault_protocol }}://{{ ansible_default_ipv4.address }}:{{ vault_port }}"
  vault_cluster_address                    = "{{ ansible_default_ipv4.address }}:{{ (vault_port | int) + 1}}"
  vault_raft_cloud_auto_join               = local.vault_raft_cloud_auto_join
  vault_raft_cloud_auto_join_exclusive     = "true"
  vault_service_registration_consul_enable = "true"
  //vault_service_registration_consul_address = var.vault_service_registration_consul_address
  //vault_service_registration_consul_token   = var.vault_consul_token
  vault_service_registration_consul_template = "vault_service_registration_consul.hcl.j2"
  vault_tls_disable                          = "true"
  vault_systemd_template                     = "vault_service_systemd.j2"
  vault_raft_cloud_auto_join_scheme          = "http"
  vault_manage_group                         = "true"
  vault_group                                = "vault"
}
