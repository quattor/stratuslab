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

#
# Variable usefull for Hypervisor configuration
#
variable STRATUSLAB_PDISK_TYPE ?= 'iscsi';
variable STRATUSLAB_PDISK_NFS_LOCATION ?= '/mnt/pdisk';
variable STRATUSLAB_PDISK_ISCSIADM ?= '/sbin/iscsiadm';
variable STRATUSLAB_PDISK_CURL ?= '/usr/bin/curl';
variable STRATUSLAB_PDISK_REGISTER_FILENAME ?= 'pdisk';

#
# Variable usefull for server
#
variable STRATUSLAB_PDISK_USER_PER_PDISK ?= 1;
variable STRATUSLAB_PDISK_SSH_KEY ?= '/opt/stratuslab/storage/pdisk/cloud_node.key';
variable STRATUSLAB_PDISK_SSH_USER ?= 'oneadmin';
variable STRATUSLAB_PDISK_VM_DIR ?= '/var/lib/one';

variable STRATUSLAB_PDISK_ISCSI_TYPE ?= 'lvm';
variable STRATUSLAB_PDISK_ISCSI_FILE_LOCATION ?= STRATUSLAB_PDISK_NFS_LOCATION;
variable STRATUSLAB_PDISK_ISCSI_CONF ?= '/etc/tgt/targets.conf';
variable STRATUSLAB_PDISK_ISCSI_ADMIN ?= '/usr/sbin/tgt-admin';

variable STRATUSLAB_PDISK_LVM_VGDISPLAY ?= '/sbin/vgdisplay';
variable STRATUSLAB_PDISK_LVM_CREATE    ?= '/sbin/lvcreate';
variable STRATUSLAB_PDISK_LVM_REMOVE    ?= '/sbin/lvremove';
variable STRATUSLAB_PDISK_LVM_CHANGE    ?= '/sbin/lvchange';
variable STRATUSLAB_PDISK_LVM_DMSETUP   ?= '/sbin/dmsetup';

variable STRATUSLAB_PDISK_ZOOKEEPER_URI ?= '127.0.0.1:2181';