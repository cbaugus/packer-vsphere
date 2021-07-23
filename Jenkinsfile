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
                num_instances: "1",
                name_prefix: "ops-pool-a-large",
                resource_pool_type: "large"
            ],
            terraformVarsFiles: [
                vsphereVarFile: "./vsphere-vars.tfvars",
                provisionerVarFile: "./provisioner-vars.tfvars",
                consulVarFile: "./consul-vars.tfvars",
                nomadVarFile: "./nomad-vars.tfvars"
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
                    graphFlag: false,
                    terraformVarsFiles: [
                        "vsphereVarFile",
                        "provisionerVarFile",
                        "consulVarFile",
                        "nomadVarFile"
                    ]
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
