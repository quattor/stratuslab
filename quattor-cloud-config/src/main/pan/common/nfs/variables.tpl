unique template common/nfs/variables;

include { 'stratuslab/default/parameters' };

variable STRATUSLAB_NFS_SERVER      ?= error('STRATUSLAB_NFS_SERVER must be declared');
variable STRATUSLAB_NFS_WILDCARD    ?= error('STRATUSLAB_NFS_WILDCARD must be declared');
variable STRATUSLAB_NFS_MOUNT_POINT ?= '/stratuslab_mnt';

variable STRATUSLAB_NFS_SERVER_VAR  ?= STRATUSLAB_NFS_SERVER;
variable STRATUSLAB_NFS_SERVER_HOME ?= STRATUSLAB_NFS_SERVER;

variable STRATUSLAB_NFS_VARDIR_ENABLE  ?= true;
variable STRATUSLAB_NFS_SERVER_VARDIR  ?= STRATUSLAB_ONE_VARDIR;
variable STRATUSLAB_NFS_SERVER_HOMEDIR ?= format("%s/%s",STRATUSLAB_UNIX_USER_HOME,
                                                         STRATUSLAB_UNIX_USER_ACCOUNT);

