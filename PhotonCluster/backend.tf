# TODO: abstract variables - not allowed in this block
# https://www.terraform.io/docs/language/settings/backends/remote.html#prefix
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      name = "photon-worker-fleet"
    }
  }
}
