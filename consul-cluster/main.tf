module "cluster" {
  source  = "app.terraform.io/JohnstonHowse/cluster-module/vsphere"
  version = "0.3.6"

  #Cluster vars
  num_instances    = var.num_instances
  cores_count_type = "medium" #2 cores
  mem_size_type    = "xl"     #16 GB
  disk_size_type   = "xl"     #240 GB
  name_prefix      = var.name

  #vSphere required inputs
  vsphere_server          = var.vsphere_server
  vsphere_compute_cluster = var.vsphere_compute_cluster
  vsphere_resource_pool   = var.vsphere_resource_pool
  vsphere_datacenter      = var.vsphere_datacenter
  vsphere_datastore       = var.vsphere_datastore
  vsphere_network         = var.vsphere_network
  vsphere_folder          = local.vsphere_folder
  vsphere_template        = var.vsphere_template
  vsphere_user            = var.vsphere_user
  vsphere_pass            = var.vsphere_pass
  vsphere_tag_ids         = [data.vsphere_tag.consul.id]

  #Terraform Provisioner required inputs
  path_to_ansible          = "../../ansible-deployments/consul-server.yml"
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user

  #Consul overrides
  consul_node_role                        = "server"
  consul_bootstrap_expect                 = "true"
  consul_bootstrap_expect_value           = 3
  consul_cloud_autodiscovery_tag_category = "hashistack"
  consul_cloud_autodiscovery_tag_name     = "consul"
  consul_acl_enable                       = "true"
  consul_acl_datacenter                   = "tmi-w01-dc01" //this should be the same for all clusters
  consul_acl_down_policy                  = "allow"
  consul_acl_agent_token                  = var.consul_acl_agent_token
  consul_acl_replication_token            = var.consul_acl_replication_token
  consul_tls_ca_crt                       = "tmi-consul-agent-ca.pem"
  consul_tls_server_crt                   = "tmi-w01-dc01-server-consul-2.pem"
  consul_tls_server_key                   = "tmi-w01-dc01-server-consul-2-key.pem"
  consul_tls_verify_incoming              = "true"
  consul_tls_verify_outgoing              = "true"
  consul_tls_verify_server_hostname       = "true"
  consul_ui                               = "True"
  consul_version                          = "1.11.1"
  consul_pass                             = var.consul_pass
  //consul_datacenter      = var.vsphere_datacenter
  consul_raw_key            = var.consul_raw_key
  consul_addresses_http     = "127.0.0.1 {{ consul_bind_address }}"
  consul_ports              = { "grpc" = "8502", "dns" = "8600", "http" = "8500", "https" = "-1", "rpc" = "8400", "serf_lan" = "8301", "serf_wan" = "8302", "server" = "8300" }
  consul_node_meta          = local.consul_node_meta
  consul_dnsmasq_enable     = "True"
  consul_dnsmasq_servers    = ["10.255.203.10"]
  consul_dnsmasq_revservers = ["10.255.0.0/16"]

  #Known Hosts
  known_hosts_targets = local.known_hosts_targets
  known_hosts_user    = local.known_hosts_user
}
