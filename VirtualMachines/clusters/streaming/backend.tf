# TODO: abstract variables - not allowed in this block
# https://www.terraform.io/docs/language/settings/backends/remote.html#prefix
terraform {
  required_providers {
    vault = {
      source = "hashicorp/vault"
    }
    vsphere = {
      source = "hashicorp/vsphere"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "streaming-${terraform.workspace}"
    }
  }
}

# TF_WORKSPACE=dal-prod 
