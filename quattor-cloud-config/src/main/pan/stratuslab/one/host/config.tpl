unique template stratuslab/one/host/config;

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

#
# Include the packages (RPMs) for the node.
#
include { 'stratuslab/one/rpms/'+STRATUSLAB_SPMA_VERSION+'/node' };
include { 'stratuslab/one/rpms/'+STRATUSLAB_SPMA_VERSION+'/devel' };
