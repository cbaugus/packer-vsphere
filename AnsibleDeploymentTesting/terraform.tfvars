vsphere_datacenter = "dal-w01-dc01"

vsphere_compute_cluster = "dal-w01-cl01"

vsphere_resource_pool = "dal-w01-dc01/dal-w01-cl01/Resources"

vsphere_datastore = "dal-w01-cl01-ds-vsan01"

vsphere_network = "dal-w01-cl01-vds01-pg-ops-203"

vsphere_folder = "Infrastructure/Ansible"

vsphere_template = "linux-ubuntu-server-20-04-lts"

vsphere_template_ubuntu = "linux-ubuntu-server-20-04-lts"

vsphere_template_photon = "linux-photon-server-4"

vsphere_template_debian = "linux-server-debian-10-base-template"

vsphere_template_centos = "linux-server-centos-8-base-template"

name_prefix = "ansible-deployment-testing"

ansible_extra_vars = {
  "ansible_python_interpreter"  = "/usr/bin/python3"
  "hostname"                    = "ansible-deployment-testing-ubuntu-1"
  "consul_group_name"           = "all"
  "consul_group"                = "consul_instances"
  "vault_backend"               = "consul"
  "vault_service_restart"       = "false"
  "nomad_group_name"            = "nomad"
}
