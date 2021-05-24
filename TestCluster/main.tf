terraform {
  backend "remote" {
    organization = "JohnstonHowse"

    workspaces {
      name = "cli-vsphere-testing"
    }
  }
}

module "testcluster1" {
  source = "../modules/terraform-vsphere-vm"
  dc = ""
  vmrp = ""
  vmtemp = ""
}
