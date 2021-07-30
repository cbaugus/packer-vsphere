String pipelineVersion = "development"
library("jenkins-pipeline@${pipelineVersion}")

loglevel = "DEBUG"

components = [
    vsphereVMs: [
        name: "vsphereVMs",
        description: "Photon worker fleet",
        version: "latest",
        type: "infrastructure",
        config: [
            infrastructureType: "vsphere",
            terraformDirectories: [
                directory1: "PhotonCluster"
            ],
            terraformVars: [
                num_instances: "1",
                name_prefix: "photon-pool-a-small",
                resource_pool_type: "small"
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
        title: "Deploy Photon Fleet",
        description: "Deploy cluster of Photon OS VMs",
        type: "install",
        agent: "agent-deploytools",
        config: [
            installType: "infrastructure_install",
            infrastructure: "vsphereVMs",
            targetEnv: "dalDC01", //TODO: Create environment generic from Packer or Terraform for both to use
            targets: [
                vsphereVMs: [
                    name: "PhotonCluster",
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
