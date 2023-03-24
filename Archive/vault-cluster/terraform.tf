terraform {
  required_version = ">= 1.1.2"
  cloud {
    organization = "JohnstonHowse"

    workspaces {
      tags = ["vault"]
    }
  }
}