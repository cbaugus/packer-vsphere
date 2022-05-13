num_instances      = "10"
name               = "web"
env                = "prod"
//sub_envs           = [
//  "prod"
//]

#NFS Vars
nfs_mount_server   = "10.254.25.25:/mnt/fs-pool-a/nfs-root"
nfs_mount_options  = "rw,nolock,hard,rsize=8192,wsize=8192,timeo=30,vers=3"
nfs_mount_path     = "/mnt/nfs/prod"
