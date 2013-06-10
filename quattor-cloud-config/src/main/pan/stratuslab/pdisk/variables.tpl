unique template stratuslab/pdisk/variables;

#
# Pdisk super user, by default pdisk
#
variable STRATUSLAB_PDISK_SUPER_USER     ?= 'pdisk';
variable STRATUSLAB_PDISK_SUPER_USER_PWD ?= error("STRATUSLAB_PDISK_SUPER_USER_PWD must be declared");

#
# Global variable for Hypervisor and Server
#

variable STRATUSLAB_PDISK_BACKEND_TYPE ?= error("STRATUSLAB_PDISK_BACKEND_TYPE must be declared ( file for file-sharing based pdisk / iscsi for iscsi backend type)");

#
# Variable usefull for OpenNebula frontend configuration (tm_stratuslab)
#
variable STRATUSLAB_PDISK_HOST    ?= error("STRATUSLAB_PDISK_HOST must be declared");
variable STRATUSLAB_PDISK_TMP_DIR ?= STRATUSLAB_ONE_VARDIR + '/images/';
variable STRATUSLAB_PDISK_SCRIPT  ?= 'python';

#
# Variable usefull for Hypervisor configuration
#
variable STRATUSLAB_PDISK_TYPE              ?= if ( STRATUSLAB_PDISK_BACKEND_TYPE == "iscsi" ) {
  "iscsi";
} else {
  "nfs";
};
variable STRATUSLAB_PDISK_NFS_DIRECTORY     ?= STRATUSLAB_ONE_VARDIR;
variable STRATUSLAB_PDISK_NFS_LOCATION      ?= STRATUSLAB_PDISK_NFS_DIRECTORY + '/pdisks';
variable STRATUSLAB_PDISK_ISCSIADM          ?= '/sbin/iscsiadm';
variable STRATUSLAB_PDISK_CURL              ?= '/usr/bin/curl';
variable STRATUSLAB_PDISK_REGISTER_FILENAME ?= 'pdisk';

#
# Variable usefull for server
#
variable STRATUSLAB_PDISK_USER_PER_PDISK   ?= 1;
variable STRATUSLAB_PDISK_SSH_KEY          ?= '/opt/stratuslab/storage/pdisk/cloud_node.key';
variable STRATUSLAB_PDISK_SSH_USER         ?= STRATUSLAB_UNIX_USER_ACCOUNT;
variable STRATUSLAB_PDISK_ROOT_PRIVATE_KEY ?= STRATUSLAB_ROOT_PRIVATE_KEY;
variable STRATUSLAB_PDISK_VM_DIR           ?= STRATUSLAB_ONE_VARDIR;

variable STRATUSLAB_PDISK_ISCSI_TYPE          ?= 'lvm';
variable STRATUSLAB_PDISK_ISCSI_FILE_LOCATION ?= STRATUSLAB_PDISK_NFS_LOCATION;
variable STRATUSLAB_PDISK_ISCSI_CONF          ?= '/etc/tgt/targets.conf';
variable STRATUSLAB_PDISK_ISCSI_ADMIN         ?= '/usr/sbin/tgt-admin';
variable STRATUSLAB_PDISK_ISCSI_DEVICE        ?= '/dev/vg.02';

variable STRATUSLAB_PDISK_CACHE_LOCATION ?= '/var/tmp/stratuslab';

variable STRATUSLAB_PDISK_UTILS_GZIP   ?= '/usr/bin/gzip';
variable STRATUSLAB_PDISK_UTILS_GUNZIP ?= '/usr/bin/gunzip';

variable STRATUSLAB_PDISK_BACKEND_CONFIG ?= '/etc/stratuslab/pdisk-backend.cfg';
variable STRATUSLAB_PDISK_BACKEND_CMD    ?= '/usr/sbin/persistent-disk-backend.py';

#
# OBSOLETE : Variable usefull for lvm configuration
#
variable STRATUSLAB_PDISK_LVM_VGDISPLAY ?= '/sbin/vgdisplay';
variable STRATUSLAB_PDISK_LVM_CREATE    ?= '/sbin/lvcreate';
variable STRATUSLAB_PDISK_LVM_REMOVE    ?= '/sbin/lvremove';
variable STRATUSLAB_PDISK_LVM_CHANGE    ?= '/sbin/lvchange';
variable STRATUSLAB_PDISK_LVM_DMSETUP   ?= '/sbin/dmsetup';

#
# Variable usefull for MySQL Configuration
#
variable STRATUSLAB_PDISK_MYSQL_DATABASE ?= 'storage';
variable STRATUSLAB_PDISK_MYSQL_USER     ?= MYSQL_USER;
variable STRATUSLAB_PDISK_MYSQL_PASSWORD ?= MYSQL_PASSWORD;
variable STRATUSLAB_PDISK_MYSQL_HOST     ?= MYSQL_HOST;

#
# Variable for pdisk-backend.cfg file
#
variable STRATUSLAB_PDISK_PROXIES        ?= 'local';
variable STRATUSLAB_PDISK_PROXY_USERNAME ?= 'root';
variable STRATUSLAB_PDISK_PROXY_SSHKEYS  ?= '/some/dir/key.rsa';
variable STRATUSLAB_PDISK_PROXY_TYPE     ?= if ( STRATUSLAB_PDISK_BACKEND_TYPE == "iscsi" ) {
  "Lvm";
} else {
  "File";
};
variable STRATUSLAB_PDISK_PROXY_LOCATION ?= if ( STRATUSLAB_PDISK_BACKEND_TYPE == "iscsi" ) {
  STRATUSLAB_PDISK_ISCSI_DEVICE;
} else {
  STRATUSLAB_PDISK_NFS_LOCATION;
};
variable STRATUSLAB_PDISK_PROXY_SECTIONS ?= format("[%s]\ntype=%s\nvolume_name=%s",STRATUSLAB_PDISK_PROXIES,
                                                                                   STRATUSLAB_PDISK_PROXY_TYPE,
                                                                                   STRATUSLAB_PDISK_PROXY_LOCATION);

