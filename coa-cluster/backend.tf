terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "frankspeech-coa-tmi-w01-dc01-"
    }
  }
}
