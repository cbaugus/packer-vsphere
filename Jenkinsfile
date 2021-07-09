String pipelineVersion = "feature/FI-435-terraform-ansible-provisioning"
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
                directory1: "AnsibleDeploymentTesting"
            ],
            terraformVars: [
                num_instances: "1"
            ],
            terraformVarsFiles: [
                file1: ""
            ]
        ],
        scm: [
             current: [
                 repoName: "terraform-vsphere",
                 branchName: "${env.BRANCH_NAME}"
             ],
             ansible: [
                  repoName: "ansible-deployments",
                  branchName: "develop"
              ]
        ]
    ]
    //TODO: Clone ansible-deployments for provisioning
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
                    name: "AnsibleDeploymentTesting",
                    strategy: "terraform"
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