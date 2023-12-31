module "cluster" {
  source  = "app.terraform.io/JohnstonHowse/cluster-module/vsphere"
  version = "0.3.8"

  #Cluster vars
  num_instances    = var.num_instances
  cores_count_type = "medium"
  mem_size_type    = "xxxl"
  disk_size_type   = "medium"
  name_prefix      = "${var.name}-${var.env}"

  #vSphere required inputs
  vsphere_compute_cluster = var.vsphere_compute_cluster
  vsphere_resource_pool   = var.vsphere_resource_pool
  vsphere_datastore       = var.vsphere_datastore
  vsphere_network         = var.vsphere_network
  vsphere_folder          = local.vsphere_folder
  vsphere_template        = var.vsphere_template
  vsphere_user            = var.vsphere_user
  vsphere_pass            = var.vsphere_pass

  #Terraform Provisioner required inputs
  path_to_ansible          = "../../ansible-deployments/cluster-bootstrap.yml"
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user

  #Consul overrides
  consul_pass               = var.consul_pass
  consul_raw_key            = var.consul_raw_key
  consul_addresses_http     = "127.0.0.1 {{ consul_bind_address }}"
  consul_ports              = { "grpc" = "8502", "dns" = "8600", "http" = "8500", "https" = "-1", "rpc" = "8400", "serf_lan" = "8301", "serf_wan" = "8302", "server" = "8300" }
  consul_acl_agent_token    = var.consul_acl_token
  consul_node_meta          = local.consul_node_meta
  consul_dnsmasq_enable     = "True"
  consul_dnsmasq_servers    = ["10.254.203.11", "10.254.203.12"]
  consul_dnsmasq_revservers = ["10.254.0.0/16"]

  #Nomad overrides
  nomad_region                = local.nomad_region
  nomad_node_class            = var.env
  nomad_vault_address         = local.nomad_vault_address
  nomad_vault_tls_skip_verify = var.nomad_vault_tls_skip_verify
  nomad_options               = var.nomad_options
  nomad_meta                  = local.nomad_meta
  nomad_consul_token          = data.consul_acl_token_secret_id.nomad_client_token.secret_id

  #Vault overrides
  vault_agent_role_id            = var.vault_agent_role_id
  vault_agent_secret_id          = var.vault_agent_secret_id
  vault_consul_role_cluster_type = var.name
  vault_agent_templates          = local.vault_agent_templates
  vault_docker_secrets           = var.vault_docker_secrets

  #Docker overrides
  docker_vault_login = var.docker_vault_login

  #Known Hosts
  known_hosts_targets = local.known_hosts_targets
  known_hosts_user    = local.known_hosts_user
}
