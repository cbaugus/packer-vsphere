terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "frankspeech-coa-search-tmi-w01-dc01-"
    }
  }
}
