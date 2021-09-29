terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "frankspeech-dbcache-tmi-w01-dc01-"
    }
  }
}
