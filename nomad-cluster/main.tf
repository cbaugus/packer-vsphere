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
  vsphere_tag_ids         = [data.vsphere_tag.nomad.id]

  #Terraform Provisioner required inputs
  path_to_ansible          = "../../ansible-deployments/nomad-server.yml"
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user

  nomad_node_role            = "server"
  nomad_region               = var.nomad_region
  nomad_datacenter           = var.vsphere_datacenter //this ties the name of the Nomad DC to the vSphere DC name
  nomad_authoritative_region = "tmi"                  //this is not a variable because all Nomad clusters should refer to TMI as the single source of ACLs
  //nomad_network_interface = "" likely want this to be ens192
  nomad_meta = {
    "node-switcher" = "on"
    "purpose"       = "nomad"
  }
  // nomad_docker_enable = "no" the default is yes for the cluster module - not sure what we want on servers yet
  nomad_use_consul            = "no" //default is yes, need to flip this back on once Consul client provisioning is configured, will need other nomad_consul vars to go along with this
  nomad_acl_enabled           = ""
  nomad_acl_replication_token = ""
  nomad_vault_enabled         = "no" //must change back to yes once Vault is ready
}
