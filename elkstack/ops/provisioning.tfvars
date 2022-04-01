provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "elk_label"
    disk_size                 = "xxl"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]


nomad_vault_address         = "https://vault.service.tmi-w01-dc01.consul:8200"





