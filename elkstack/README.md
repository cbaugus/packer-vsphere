# Web Cluster

## Manual Terraform Operations

### Pre-requisites

1. SSH to a machine which can access the vSphere API (ex. deploy01)
2. Set VAULT_ADDR env var: `export VAULT_ADDR=https://vault.service.<datacenter>.consul:8200`
3. Set VAULT_SKIP_VERIFY env var, or set VAULT_CLIENT_KEY, VAULT_CLIENT_CERT, and VAULT_CACERT env vars
4. Login to Vault via LDAP: `vault login -method=ldap username=my-username`
5. From the "web-cluster" folder, run "source ../auth.sh" and answer the prompts accordingly - this script sets the necessary Terraform secret vars as env vars (TF_VAR_ prefixed)

### Execution

1. `terraform workspace select <workspace-name>
2. `terraform plan -var-file=envs/<region>/<env>/main.tfvars -var-file=envs/<region>/<env>/cloud.tfvars -out=plan.out`
3. `terraform apply plan.out`

## Pipeline Terraform Operations 

TBD