num_instances      = "10"
name               = "web"
env                = "nonprod"
//sub_envs           = {
//  1 = "dev"
//  2 = "test"
//  3 = "stage"
//}

#NFS Vars
nfs_mount_server   = "10.254.225.100:/mnt/disk-pool/nfs-root"
nfs_mount_options  = "rw,nolock,hard,rsize=8192,wsize=8192,timeo=30,vers=3"
nfs_mount_path     = "/mnt/nfs/nonprod"