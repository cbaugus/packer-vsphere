String pipelineVersion = "feature/FI-424-infra-pipeline-fixes"
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
                    name: "prototypeCluster",
                    strategy: "terraform"
                ]
            ]
        ],
        withScm: [
            scmEnv: "frankBitBucketRepoHost",
            scmName: "current"
            //TODO: Add ansible-deployments
        ]
    ]
]

runPipeline(components, stages, loglevel)