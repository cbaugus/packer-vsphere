terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "web-internal-tmi-w01-dc01-"
    }
  }
}
