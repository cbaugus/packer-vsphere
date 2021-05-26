# TODO: abstract variables - not allowed in this block
terraform {
  backend "remote" {
    #organization = "example-org-186bcc"
    organization = "JohnstonHowse"

    workspaces {
      #name = "jh-test-cli"
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
