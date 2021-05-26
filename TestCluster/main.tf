# TODO: abstract variables - not allowed in this block
terraform {
  backend "remote" {
  
    organization = "JohnstonHowse"

    workspaces {
      name = "cli-vsphere-testing2"
    }
  }
}

# TODO: Implement local copy of module
/*
module "testcluster1" {
  source = "../modules/terraform-vsphere-vm"
  dc = ""
  vmrp = ""
  vmtemp = ""
}
*/
