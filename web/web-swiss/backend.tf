terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "frankspeech"

    workspaces {
      prefix = "web-swiss-v2-"
    }
  }
}
