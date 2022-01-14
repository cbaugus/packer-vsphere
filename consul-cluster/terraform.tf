terraform {
  required_version = ">= 1.1.0"
  cloud {
    organization = "JohnstonHowse"

    workspaces {
      tags = ["consul", "vsphere"]
    }
  }
}
