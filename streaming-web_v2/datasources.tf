########## VAULT ##########
// data "vault_generic_secret" "streaming_minio_secrets" {
//   path = local.streaming_minio_vault_path
// }
//
// data "vault_generic_secret" "streaming_public_minio_secrets" {
//   path = local.streaming_public_minio_vault_path
// }

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

//data "consul_acl_token_secret_id" "nomad_client_token" {
 // accessor_id = var.env == "prod" ? lookup(data.terraform_remote_state.consul.outputs.nomad_client_prod_token_accessors, var.name, "") : lookup(data.terraform_remote_state.consul.outputs.nomad_client_nonprod_token_accessors, var.name, "")
//}