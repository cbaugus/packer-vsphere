########## VAULT ##########
# TODO: There is some issue with the vault provider where prod/minio/jenkins-master/tmi-w01-dc01 is not being found,
#       even thought it is there and queryable through the CLI
// data "vault_generic_secret" "minio_s3" {
//   path = local.minio_vault_path
// }
