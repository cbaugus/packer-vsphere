terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "JohnstonHowse"

    workspaces {
      prefix = "ops-v2-"
    }
  }
}
