terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "frankspeech-REPLACEME_cluster_name_REPLACEME-tmi-w01-dc01-"
    }
  }
}
