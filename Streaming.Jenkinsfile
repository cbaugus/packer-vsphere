
String pipelineVersion = "feature/terraform-vault"
library("jenkins-pipeline@${pipelineVersion}")

// PIPELINE VARS
targetInfraEnv = "unknown"
targetConfigs = "unknown"
namePrefix = "unknown"
loglevel = "DEBUG"

// BRANCH PATTERNS
featureBranchPattern = "feature/"
developmentBranchPattern = "develop"
testBranchPattern = "test"
hotfixBranchPattern = "hotfix/"
releaseBranchPattern = "release/"
masterBranchPattern = "master"

// DETERMINE PIPELINE VARS BASED ON BRANCH PATTERN
if (env.BRANCH_NAME =~ ".*${featureBranchPattern}.*") {
  targetConfigs = "feature"
  targetInfraEnv = "dalDC01_feature"
  namePrefix = env.BRANCH_NAME.replaceAll("/", "-")
} else if (env.BRANCH_NAME =~ ".*${developmentBranchPattern}.*") {
  targetConfigs = "dev"
  targetInfraEnv = "dalDC01_dev"
  namePrefix = "dev"
} else if (env.BRANCH_NAME =~ ".*${testBranchPattern}.*") {
  targetConfigs = "test"
  targetInfraEnv = "dalDC01_test"
  namePrefix = "test"
} else if (env.BRANCH_NAME =~ ".*${releaseBranchPattern}.*") {
  targetConfigs = "staging"
  targetInfraEnv = "dalDC01_staging"
  namePrefix = "staging"
} else if (env.BRANCH_NAME =~ ".*${masterBranchPattern}.*" || env.BRANCH_NAME =~ ".*${hotfixBranchPattern}.*") {
  targetConfigs = "prod"
  targetInfraEnv = "dalDC01_prod"
  namePrefix = "prod"
}

components = [
    streaming_cluster: [
        name: "streaming_cluster",
        description: "Streaming Cluster",
        version: "latest",
        type: "infrastructure",
        config: [
            infrastructureType: "vsphere",
            terraformDirectories: [
                mainDirectory: "VirtualMachines"
            ],
            terraformVars: [
                name_prefix: "streaming-cluster-${namePrefix}",
                consul_src_def: "/root/.ssh",
                consul_tls_src_files: "/root/.ssh"
            ],
            terraformVarsFiles: [
                mainVarsFiles: "./clusters/streaming/${targetConfigs}/main.tfvars",
                cloudVarsFiles: "./clusters/streaming/${targetConfigs}/cloud.tfvars",
                provisioningVarsFiles: "./clusters/streaming/${targetConfigs}/provisioning.tfvars",
            ],
            terraformBackendFiles: [
                mainBackendFile: "./clusters/streaming/backend.tf",
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
    deploy_streaming_cluster: [
        title: "Deploy Streaming Cluster",
        description: "Deploy Streaming Cluster to vSphere",
        type: "install",
        agent: "agent-deploytools",
        config: [
            installType: "infrastructure_install",
            infrastructure: "streaming_cluster",
            targetEnv: targetInfraEnv, //TODO: Create environment generic from Packer or Terraform for both to use
            targets: [
                vsphereVMs: [
                    name: "streaming_cluster",
                    strategy: "terraform",
                    graphFlag: false,
                    terraformDirectory: "mainDirectory",
                    terraformVars: [
                        "name_prefix"
                    ],
                    terraformVarsFiles: [
                        "mainVarsFiles",
                        "cloudVarsFiles",
                        "provisioningVarsFiles"
                    ],
                    terraformBackendFile: "mainBackendFile"
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
