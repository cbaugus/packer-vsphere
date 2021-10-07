########## VAULT ##########
data "vault_generic_secret" "minio_s3" {
  path = local.minio_vault_path
}
