unique template stratuslab/one/host/config;

'/software/packages/{qemu-kvm}' ?= nlist();
'/software/packages/{libvirt}'  ?= nlist();
'/software/packages/{ruby}'     ?= nlist();
#
# Setup oneadmin account, libvirtd, and networking
#
include { 'stratuslab/one/service/common-config' };
include { 'stratuslab/one/service/node-config' };

#
# Import the common areas from the OpenNebula server.
#
include {
  if( STRATUSLAB_NFS_ENABLE ) {
    'common/nfs/nfs-imports';
  } else {
    null;
  };
};

