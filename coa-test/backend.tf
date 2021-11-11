terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "coa-test-tmi-w01-dc01-"
    }
  }
}
