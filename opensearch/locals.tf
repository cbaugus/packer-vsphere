
locals {
  growr_provisioned_disks = []
  s3_provisioned_disks = []

  known_hosts_user = "root"
  known_hosts_targets = [
    "bitbucket.org"
  ]

  vault_agent_templates = [
  ]
}
