module "cluster" {
  source  = "app.terraform.io/baugus-lab/cluster-module/vsphere"
  version = "2.0.5"

  #Cluster vars
  num_instances      = var.num_instances
  cores_count_type = var.resource_pool_type
  mem_size_type    = var.resource_pool_type
  disk_size_type   = "medium"
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
  path_to_ansible          = "../../ansible-deployments/web-cluster-bootstrap.yml"
  remote_exec_ssh_key_file = var.remote_exec_ssh_key_file
  local_exec_ssh_key_file  = var.local_exec_ssh_key_file
  local_exec_user          = var.local_exec_user

  #S3/Growr overrides
  provisioned_disks    = var.provisioned_disks
  growr_provisioned_disks = local.growr_provisioned_disks

  #Consul overrides
  consul_acl_agent_token      = var.consul_acl_token
  consul_acl_token            = var.consul_acl_token
  consul_pass    = var.consul_pass
  consul_raw_key = var.consul_raw_key
  consul_iptables_enable = "false"
  consul_dnsmasq_enable = "True"
  consul_dnsmasq_servers = [ "10.254.203.11",  "10.254.203.12" ]
  consul_dnsmasq_revservers = [ "10.254.0.0/16" ]

  #Nomad overrides
  nomad_region                = var.nomad_region
  nomad_node_class            = var.nomad_node_class
  nomad_purpose               = var.nomad_purpose
  nomad_vault_address         = var.nomad_vault_address
  nomad_vault_tls_skip_verify = var.nomad_vault_tls_skip_verify
  nomad_options               = var.nomad_options
  nomad_plugins               = var.nomad_plugins
  nomad_meta                  = var.nomad_meta
  //nomad_host_volumes          = var.nomad_host_volumes
  nomad_consul_token          = var.nomad_node_token
  //nomad_consul_token          = var.consul_acl_token  //data.consul_acl_token_secret_id.nomad_client_token.secret_id
  //nomad_consul_token          = data.consul_acl_token_secret_id.nomad_client_token.secret_id


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

  #NFS Vars for Prod
    nfs_mount_server   = "10.254.205.25:/mnt/fs-pool-a/nfs-root"
    nfs_mount_options  = "rw,nolock,hard,rsize=8192,wsize=8192,timeo=30,vers=3"
    nfs_mount_path     = "/mnt/nfs/prod"
/*
 #NFS Vars for Nonprod
 nfs_mount_server   = "10.254.225.100:/mnt/disk-pool/nfs-root"
 nfs_mount_options  = "rw,nolock,hard,rsize=8192,wsize=8192,timeo=30,vers=3"
 nfs_mount_path     = "/mnt/nfs/nonprod"
   */
}
