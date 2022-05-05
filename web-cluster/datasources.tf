########## VAULT ##########
//data "vault_generic_secret" "minio_s3" {
//  for_each = var.sub_envs
//  path     = "${each.value}/minio/${var.name}/${var.vsphere_datacenter}"
//}

//data "vault_generic_secret" "dev_minio_s3" {
//  path = "dev/minio/${var.name}/${var.vsphere_datacenter}"
//}
//
//data "vault_generic_secret" "test_minio_s3" {
//  path = "test/minio/${var.name}/${var.vsphere_datacenter}"
//}
//
//data "vault_generic_secret" "stage_minio_s3" {
//  path = "stage/minio/${var.name}/${var.vsphere_datacenter}"
//}

#data "vault_generic_secret" "prod_minio_s3" {
#  path = "prod/minio/${var.name}/${var.vsphere_datacenter}"
#}


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