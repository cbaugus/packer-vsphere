terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "streaming-web-tmi-w01-dc01-"
    }
  }
}
