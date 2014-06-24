unique template stratuslab/one/server/config;

include { 'stratuslab/one/variables' };

'/software/packages/{stratuslab-cli-sysadmin}' ?= nlist();
'/software/packages/{one-3.2-StratusLab}'      ?= nlist();
'/software/packages/{stratuslab-nginx-load}'   ?= nlist();

#
# Configure NFS if needed
#
include {
 if ( STRATUSLAB_NFS_ENABLE ) {
    'common/nfs/nfs-exports';
  } else {
    null;
  };
};

include {
 if ( STRATUSLAB_NFS_ENABLE ) {
    'common/nfs/nfs-imports';
  } else {
    null;
  };
};

#
# Setup the ssh keys and configuration for oneadmin account.
#
include { 'stratuslab/one/service/oneadmin-ssh-setup' };

#
# Setup the OpenNebula daemon itself.
#
include { 'stratuslab/one/service/daemon' };

#
# Setup the OpenNebula networking.
#
include { 'stratuslab/one/service/onevnet-config' };

#
# Setup the OpenNebula hypervisor
#
include { 'stratuslab/one/server/node-config' };

#
# Setup mysql if we want use mysql backend
#
include {
  if ( ONE_SQL_BACKEND == 'mysql' ) {
    'stratuslab/one/service/mysql';
  };
};

# Authentication proxy
include { 'stratuslab/one-proxy/config' };

# Add oneadmin account
include { 'stratuslab/one/service/common-config' };

# Add private interface
include { 'stratuslab/one/service/private-network' };

include { 'stratuslab/one/service/iptables-frontend' };

include { 'stratuslab/one/service/tm_stratuslab' };

