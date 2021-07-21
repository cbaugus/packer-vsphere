String pipelineVersion = "development"
library("jenkins-pipeline@${pipelineVersion}")

loglevel = "DEBUG"

components = [
    vsphereVMs: [
        name: "vsphereVMs",
        description: "Prototype cluster of VMs",
        version: "latest",
        type: "infrastructure",
        config: [
            infrastructureType: "vsphere",
            terraformDirectories: [
                directory1: "PrototypeCluster"
            ],
            terraformVars: [
                num_instances: "2",
                name_prefix: "ops-pool-a-small",
                resource_pool_type: "small",
                vsphere_datacenter: "dal-w01-dc01",
                vsphere_compute_cluster: "dal-w01-cl01",
                vsphere_resource_pool: "dal-w01-dc01/dal-w01-cl01/Resources",
                vsphere_datastore: "dal-w01-cl01-ds-vsan01",
                vsphere_network: "dal-w01-cl01-vds01-pg-ops-203",
                vsphere_folder: "Infrastructure/TerraformTesting",
                vsphere_template: "linux-ubuntu-server-20-04-lts",
                remote_exec_user: "cicduser",
                remote_exec_timeout: "3m",
                remote_exec_command: "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add - && sudo apt-add-repository 'deb [arch=amd64] https://apt.releases.hashicorp.com \$(lsb_release -cs) main' && sudo apt-get update && sudo apt-get install -y vault",
                local_exec_user: "cicduser",
                path_to_ansible: "../../ansible-deployments/main.yml",
                ansible_python_interpreter: "/usr/bin/python3",
                consul_domain: "consul.",
                consul_group_name: "all",
                consul_group: "consul_instances",
                consul_cloud_autodiscovery: "True",
                consul_src_def: "tmp"
            ],
            terraformVarsFiles: [
                file1: "" //Not yet supported
            ]
        ],
        scm: [
             current: [
                 repoName: "terraform-vsphere",
                 branchName: "${env.BRANCH_NAME}"
             ],
             ansible: [
                  repoName: "ansible-deployments",
                  branchName: "feature/add-playbook-logging"
              ]
        ]
    ]
]

stages = [
    deployVMs_vsphere: [
        title: "Deploy VM cluster",
        description: "Deploy Prototype VM cluster to vSphere",
        type: "install",
        agent: "agent-deploytools",
        config: [
            installType: "infrastructure_install",
            infrastructure: "vsphereVMs",
            targetEnv: "dalDC01", //TODO: Create environment generic from Packer or Terraform for both to use
            targets: [
                vsphereVMs: [
                    name: "PrototypeCluster",
                    strategy: "terraform",
                    graphFlag: false
                ]
            ]
        ],
        withScm: [
            primaryScm: [
                scmEnv: "frankBitBucketRepoHost",
                scmName: "current"
            ],
            extraScm1: [
                scmEnv: "frankBitBucketRepoHost",
                scmName: "ansible"
            ]
        ]
    ]
]

runPipeline(components, stages, loglevel)
