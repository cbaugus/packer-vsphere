module "cluster" {
  source  = "app.terraform.io/JohnstonHowse/cluster-module/vsphere"
  version = "0.3.5"

  #Cluster vars
  num_instances      = var.num_instances
  cores_count_type = var.resource_pool_type
  mem_size_type    = var.resource_pool_type
  disk_size_type   = var.resource_pool_type
  name_prefix        = "${var.name}-${var.nomad_node_class}"

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
  provisioned_disks    = var.provisioned_disks
  s3_provisioned_disks = local.s3_provisioned_disks
  growr_provisioned_disks = local.growr_provisioned_disks

  #Consul overrides
  consul_addresses_http       = "{{ consul_bind_address }} 127.0.0.1"
  consul_acl_agent_token      = var.consul_acl_token
  consul_pass    = var.consul_pass
  consul_raw_key = var.consul_raw_key
  consul_iptables_enable = "false"
  consul_dnsmasq_enable = "True"
  consul_dnsmasq_servers = [ "10.254.203.11",  "10.254.203.12" ]
  consul_dnsmasq_revservers = [ "10.254.0.0/16" ]

  #Nomad overrides
  nomad_region                = var.nomad_region
  nomad_node_class            = var.nomad_node_class
  nomad_vault_address         = var.nomad_vault_address
  nomad_vault_tls_skip_verify = var.nomad_vault_tls_skip_verify
  nomad_options               = var.nomad_options
  nomad_plugins               = var.nomad_plugins
  nomad_meta                  = var.nomad_meta
  nomad_host_volumes          = var.nomad_host_volumes
  nomad_consul_token          = data.consul_acl_token_secret_id.nomad_client_token.secret_id

  #Vault overrides
  vault_agent_role_id            = var.vault_agent_role_id
  vault_agent_secret_id          = var.vault_agent_secret_id
  vault_consul_role_cluster_type = var.vault_consul_role_cluster_type
  vault_agent_templates          = local.vault_agent_templates
  vault_docker_secrets           = var.vault_docker_secrets

  #Docker overrides
  docker_vault_login             = var.docker_vault_login

  #Known Hosts
  known_hosts_targets            = local.known_hosts_targets
  known_hosts_user               = local.known_hosts_user
}
