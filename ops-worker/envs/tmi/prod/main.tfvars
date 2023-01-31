vsphere_datacenter      = "tmi-w01-dc01"
vsphere_compute_cluster = "tmi-w01-cl01-prod"
vsphere_resource_pool   = "tmi-w01-dc01/tmi-w01-cl01-prod/Resources"
vsphere_datastore       = "tmi-w01-cl01-prod-ds-vsan01"
vsphere_network         = "tmi-w01-cl01-vds01-pg-ops-203"
vsphere_folder          = "prod/ops/worker"
vsphere_template        = "debian-11.6-prod"

num_instances      = "2"
resource_pool_type = "xxl"
name               = "ops-worker"
env                = "prod"

provisioned_disks = [
  {
    device_drive              = "sdb"
    label                     = "sdb_label"
    disk_size                 = "xxl"
    thin_provisioned          = "true"
    eagerly_scrub             = "false"
    data_disk_scsi_controller = "0"
  }
]


path_to_ansible          = "../../ansible-v2/worker-node.yml"

remote_exec_ssh_key_file="~/.ssh/frank/cicduser"
remote_exec_user="cicduser"


ansible_node_args="dnsmasq=true consul_mode=client nomad_mode=client vault_mode=client"
noamd_purpose="ops-worker"