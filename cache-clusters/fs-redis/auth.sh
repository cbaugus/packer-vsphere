#!/bin/sh
# PRE-REQs
# 1. jq installed
# 2. vault CLI installed
# 3. VAULT_ADDR and VAULT_SKIP_VERIFY env vars set
# 4. logged into Vault with sufficient access to secrets engines used in this script

# HOW TO USE:
# 1. Run "source ./auth.sh"

# TODO: Interpolate paths to secrets based on DC (don't hard-code DC)
printf "Environment (nonprod or prod): "
read env


#vSphere provider credentials
export TF_VAR_vsphere_server=$(vault read -format=json ops/data/vsphere | jq '.data.data.vsphere_tmi_dc01_address' | tr -d '"')
export TF_VAR_vsphere_user=$(vault read -format=json ops/data/vsphere | jq '.data.data.vsphere_tmi_dc01_terraform_username' | tr -d '"')
export TF_VAR_vsphere_pass=$(vault read -format=json ops/data/vsphere | jq '.data.data.vsphere_tmi_dc01_terraform_password' | tr -d '"')
echo "vSphere credentials set"

#Consul cloud auto-join credentials
export TF_VAR_consul_user=$(vault read -format=json ops/data/vsphere | jq '.data.data.vsphere_tmi_dc01_consul_username' | tr -d '"')
export TF_VAR_consul_pass=$(vault read -format=json ops/data/vsphere | jq '.data.data.vsphere_tmi_dc01_consul_password' | tr -d '"')
echo "Consul cloud auto-join credentials set"

#Terraform provisioners' username
export TF_VAR_local_exec_user=$(vault read -format=json ops/data/vsphere | jq '.data.data.username' | tr -d '"')
export TF_VAR_remote_exec_user=$(vault read -format=json ops/data/vsphere | jq '.data.data.username' | tr -d '"')
echo "Terraform provisioner credentials set"

#This is used to authenticate to Consul via the Consul provider to retrieve the secret ID of a token based on accessor ID
export TF_VAR_consul_provider_token=$(vault read -format=json consul/creds/operator | jq '.data.token' | tr -d '"')
echo "Consul provider credentials set"

#This is used for the Consul agent to initially authenticate to the cluster
export TF_VAR_consul_acl_token=$(vault read -format=json consul/creds/${env}-dbcluster-node | jq '.data.token' | tr -d '"')
echo "Consul agent credentials set"

export TF_VAR_nomad_consul_token=$(vault read -format=json consul/creds/nomad-node | jq '.data.token' | tr -d '"')
echo "Nomad Node Token set"

#This is used for encrypted gossip communication (Serf) in the Consul cluster
export TF_VAR_consul_raw_key=$(vault read -format=json ops/data/consul | jq '.data.data.gossip_key' | tr -d '"')
echo "Consul gossip key set"

#These vars are used for Vault Agent to authenticate to Vault
export TF_VAR_vault_agent_role_id=$(vault read -format=json auth/approle/role/prod-agent-role/role-id | jq '.data.role_id' | tr -d '"' )
export TF_VAR_vault_agent_secret_id=$(vault write -f -format=json auth/approle/role/prod-agent-role/secret-id | jq '.data.secret_id' | tr -d '"' )
echo "Vault Agent auto-auth credentials set"

#These are used by the Vault provider to authenticate to Vault
export TF_VAR_vault_server_url="https://vault.service.${datacenter}.consul:8200"
echo "Vault provider credentials set"

export TF_VAR_remote_exec_ssh_key_file="~/.ssh/frank/cicduser"
export TF_VAR_local_exec_ssh_key_file="~/.ssh/frank/cicduser"
export TF_VAR_local_exec_user="cicduser"
export TF_VAR_remote_exec_user="cicduser"