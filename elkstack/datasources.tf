########## VAULT ##########
//data "vault_generic_secret" "minio_s3" {
//  for_each = var.sub_envs
//  path     = "${each.value}/minio/${var.name}/${var.vsphere_datacenter}"
//}

########## TERRAFORM CLOUD ##########
data "terraform_remote_state" "consul" {
  backend = "remote"

  config = {
    organization = "JohnstonHowse"
    workspaces = {
      name = "frankspeech-consul-${var.vsphere_datacenter}"
    }
  }
}

data "consul_acl_token_secret_id" "nomad_client_token" {
  accessor_id = var.env == "prod" ? lookup(data.terraform_remote_state.consul.outputs.nomad_client_prod_token_accessors, var.name, "") : lookup(data.terraform_remote_state.consul.outputs.nomad_client_nonprod_token_accessors, var.name, "")
}

//data "vault_generic_secret" "consul_token" {
//  path = local.consul_token_vault_path
//}