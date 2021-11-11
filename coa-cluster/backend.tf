terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "coa-tmi-w01-dc01-"
    }
  }
}
