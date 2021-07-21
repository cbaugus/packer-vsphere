# TODO: abstract variables - not allowed in this block
# https://www.terraform.io/docs/language/settings/backends/remote.html#prefix
terraform {
  backend "remote" {
    organization = "JohnstonHowse"
    workspaces {
      name = "minio-deployment-testing"
    }
  }
}
