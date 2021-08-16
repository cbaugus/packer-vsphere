
# Terraform Vsphere

## VirtualMachines

The VirtualMachines module will allow VM clusters to be created and provisioned with ansible in Vsphere. This module is abstracted out so that it can be solely reliant on the vars files defined under `clusters`.

```
- clusters // This folder contains subfolders for each cluster type
  - data
  - streaming
  - web
  - example_cluster // This folder contains subfolders environment specific configs, as well as the backend.tf file
    - dev
    - feature
    - prod
    - staging
    - test // This folder contains vars files specific to the environment
      - .local.tfvars // This file contains variables that would be used when using the CLI locally as opposed to Jenkins
      - cloud.tfvars // This file contains variables specific to the cloud (vsphere)
      - main.tfvars // This file contains the main variables specific to the VM's
      - provisioning.tfvars // This file contains variables for ansible provisioning
    - backend.tf
```

**Backend File**
The backend.tf file under each cluster folder is used to configure the backend based on the TF_WORKSPACE var defined.

**Running in Jenkins**
Jenkins will inject variables that are used in this module. The variables injected therefore will not have to and should not be specified in a vars file if running in Jenkins. These variables are listed below:
- consul_src_def
- consul_tls_src_files
- vsphere_user
- vsphere_server
- remote_exec_ssh_key_file
- local_exec_ssh_key_file
- consul_user
- vault_server_url
- vault_approle_id
- vault_approle_secret_id
- vsphere_pass
- local_exec_user
- remote_exec_user
- consul_raw_key
- consul_pass

**Vault Integration**
Vault has been integrated into this module as an option by which to retrieve variables not specified as env vars. This is handled and injected by reference in the `main.tf`. For example, the below provisioned disks specified in a `provisioning.tfvars` file will inject the `minio_s3_streaming_access_key` and `minio_s3_streaming_secret_key` values in place of their reference after their values have been pulled from vault. This process can be repeated throughout the module for specific values we wish to rely on vault or the env for. Each secret is added to the `secrets` local value in `main.tf`.

```
provisioned_disks = [
  {
    ...
    S3_ACCESS_KEY_1 = "minio_s3_streaming_access_key"
    S3_SECRET_KEY_1 = "minio_s3_streaming_secret_key"
    ...
  }
]
```

**Executing Locally**
Before executing locally you should make sure all variables are accounted for. It is a good idea to keep a `credentials.tfvars` file locally for injecting any sensitive variables that you would not want to be saved to source code.

TF_WORKSPACE env var should be exported before initializing the backend. The aformentioned Jenkins variables also SHOULD be provided in a vars file if running locally.

The commands to execute this module locally would look like this, but will depend on the specific cluster and vars files:

```
cd VirtualMachines

terraform init -backend-config=./clusters/example_cluster/backend.tf

terraform validate

terraform plan -var=name_prefix=streaming-cluster-prod -var-file=./clusters/example_cluster/prod/main.tfvars -var-file=./clusters/example_cluster/prod/cloud.tfvars -var-file=./clusters/example_cluster/prod/provisioning.tfvars -var-file=./credentials.auto.tfvars

terraform apply ...
```
