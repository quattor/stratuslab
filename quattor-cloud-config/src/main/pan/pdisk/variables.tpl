unique template pdisk/variables;

#
# Pdisk super user, by default pdisk
#
variable STRATUSLAB_PDISK_SUPER_USER ?= 'pdisk';
variable STRATUSLAB_PDISK_SUPER_USER_PWD ?= error("STRATUSLAB_PDISK_SUPER_USER_PWD must be declared");

#
# Variable usefull for OpenNebula frontend configuration (tm_stratuslab)
#
variable STRATUSLAB_PDISK_HOST ?= error("STRATUSLAB_PDISK_HOST must be declared");
variable STRATUSLAB_PDISK_DEVICE ?= error('STRATUSLAB_PDISK_DEVICE must be declared');
variable STRATUSLAB_PDISK_TMP_DIR ?= '/var/lib/one/images/';
variable STRATUSLAB_PDISK_SCRIPT ?= 'python';

#
# Variable usefull for Hypervisor configuration
#
variable STRATUSLAB_PDISK_TYPE ?= 'iscsi';
variable STRATUSLAB_PDISK_NFS_LOCATION ?= '/mnt/pdisk';
variable STRATUSLAB_PDISK_ISCSIADM ?= '/sbin/iscsiadm';
variable STRATUSLAB_PDISK_CURL ?= '/usr/bin/curl';
variable STRATUSLAB_PDISK_REGISTER_FILENAME ?= 'pdisk';

variable STRATUSLAB_PDISK_GET_TURL ?= '';
#
# Variable usefull for server
#
variable STRATUSLAB_PDISK_USER_PER_PDISK ?= 1;
variable STRATUSLAB_PDISK_SSH_KEY ?= '/opt/stratuslab/storage/pdisk/cloud_node.key';
variable STRATUSLAB_PDISK_SSH_USER ?= ONE_USER;
variable STRATUSLAB_PDISK_ROOT_PRIVATE_KEY ?= STRATUSLAB_ROOT_PRIVATE_KEY;
variable STRATUSLAB_PDISK_VM_DIR ?= '/var/lib/one';

variable STRATUSLAB_PDISK_ISCSI_TYPE ?= 'lvm';
variable STRATUSLAB_PDISK_ISCSI_FILE_LOCATION ?= STRATUSLAB_PDISK_NFS_LOCATION;
variable STRATUSLAB_PDISK_ISCSI_CONF ?= '/etc/tgt/targets.conf';
variable STRATUSLAB_PDISK_ISCSI_ADMIN ?= '/usr/sbin/tgt-admin';

variable STRATUSLAB_PDISK_CACHE_LOCATION?= '/var/tmp/stratuslab';

variable STRATUSLAB_PDISK_UTILS_GZIP ?= '/usr/bin/gzip';
variable STRATUSLAB_PDISK_UTILS_GUNZIP ?= '/usr/bin/gunzip';

variable STRATUSLAB_PDISK_NETAPP_CONFIG ?= '/etc/stratuslab/pdisk-netapp.cfg';
variable STRATUSLAB_PDISK_NETAPP_CMD ?= '/usr/sbin/persistent-disk-netapp.py';

variable STRATUSLAB_PDISK_LVM_VGDISPLAY ?= '/sbin/vgdisplay';
variable STRATUSLAB_PDISK_LVM_CREATE    ?= '/sbin/lvcreate';
variable STRATUSLAB_PDISK_LVM_REMOVE    ?= '/sbin/lvremove';
variable STRATUSLAB_PDISK_LVM_CHANGE    ?= '/sbin/lvchange';
variable STRATUSLAB_PDISK_LVM_DMSETUP   ?= '/sbin/dmsetup';

variable STRATUSLAB_PDISK_ZOOKEEPER_URI ?= '127.0.0.1:2181';

variable STRATUSLAB_PDISK_MYSQL_DATABASE ?= 'storage';
variable STRATUSLAB_PDISK_MYSQL_USER ?= MYSQL_USER;
variable STRATUSLAB_PDISK_MYSQL_PASSWORD ?= MYSQL_PASSWORD;
variable STRATUSLAB_PDISK_MYSQL_HOST ?= MYSQL_HOST;

variable STRATUSLAB_PDISK_ISCSI_PROXIES  ?= 'local';
variable STRATUSLAB_PDISK_PROXY_USERNAME ?= 'root';
variable STRATUSLAB_PDISK_PROXY_SSHKEYS  ?= '/some/dir/key.rsa';
variable STRATUSLAB_PDISK_PROXY_TYPE ?= 'local';
variable STRATUSLAB_PDISK_PROXY_SECTIONS ?= {
    if (STRATUSLAB_PDISK_PROXY_TYPE == 'nfs') {
	format("[local]\ntype=File\nvolume_name=%s",
	       STRATUSLAB_NFS_MOUNT_POINT);
    } else {
	"[local]\ntype=Lvm\nvolume_name=/dev/vg.02";
    };
};
