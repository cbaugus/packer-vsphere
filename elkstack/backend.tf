terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "frankspeech-elkstack-tmi-w01-dc01-"
    }
  }
}
