terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "streaming-cache-tmi-w01-dc01-"
    }
  }
}
