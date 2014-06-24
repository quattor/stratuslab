unique template stratuslab/pdisk/server/config;

'/software/packages/{stratuslab-pdisk-server}' ?= nlist();
'/software/packages/{mysql-server}'            ?= nlist();
'/software/packages/{scsi-target-utils}'       ?= nlist();
'/software/packages/{iscsi-initiator-utils}'   ?= nlist();

#
# Include general parameters for StratusLab
#

include { 'stratuslab/default/parameters' };
include { 'stratuslab/pdisk/variables' };

#
# Add default system account to work with Stratuslab
#
include { 'common/accounts/default' };

#
# Include iptables configuration
#
include { 'common/iptables/base'};

#
# Repository
#
include { 'repository/config/stratuslab' };
include { 'stratuslab/pdisk/host/config' };
include { 'stratuslab/pdisk/service/daemon' };

include { 'common/nginx/config' };

#
# Include shared fs configuration
#
include {
  if ( STRATUSLAB_NFS_ENABLE ) {
    'common/nfs/nfs-exports'
  } else {
    null;
  };
};
include {
  if ( STRATUSLAB_NFS_ENABLE ) {
    'common/nfs/nfs-imports'
  } else {
    null;
  };
};

#
# Configure MySQL database for Persistent Disk
#
include { 'common/mysql/server' };
include { 'components/mysql/config' };

prefix '/software/components/mysql';

'servers/localhost/adminuser' = MYSQL_USER;
'servers/localhost/adminpwd'  = MYSQL_PASSWORD;

'databases' = {
  SELF[STRATUSLAB_PDISK_MYSQL_DATABASE]['server'] = 'localhost';
  SELF[STRATUSLAB_PDISK_MYSQL_DATABASE]['initOnce'] = true;
  SELF[STRATUSLAB_PDISK_MYSQL_DATABASE]['users'][escape(STRATUSLAB_PDISK_MYSQL_USER+'@localhost')] = nlist('password',STRATUSLAB_PDISK_MYSQL_PASSWORD,
                                                                                                           'rights', list('ALL PRIVILEGES'),
                                                                                                     );
  SELF[STRATUSLAB_PDISK_MYSQL_DATABASE]['tableOptions']['short_fields']['MAX_ROWS'] = '1000000000';
  SELF[STRATUSLAB_PDISK_MYSQL_DATABASE]['tableOptions']['long_fields']['MAX_ROWS'] = '55000000';
  SELF[STRATUSLAB_PDISK_MYSQL_DATABASE]['tableOptions']['events']['MAX_ROWS'] = '175000000';
  SELF[STRATUSLAB_PDISK_MYSQL_DATABASE]['tableOptions']['states']['MAX_ROWS'] = '9500000';
  
  SELF;
};

include { 'components/symlink/config' };

prefix '/software/components/symlink';

'links'=push(nlist(
  'name','/opt/stratuslab/storage/pdisk/cloud_node.key',
  'target', '/home/oneadmin/.ssh/id_rsa',
  'exists', false,
  'replace', nlist('all','yes')
));

#
# Sudo configuration to allow --save option
#

include { 'stratuslab/pdisk/server/sudo' };

#
# Create pdisk directory folder
#
include { 'components/dirperm/config' };

'/software/components/dirperm/paths' = push(
  nlist(
    'path', STRATUSLAB_PDISK_NFS_LOCATION,
    'owner', 'root:root',
    'perm', '0755',
    'type', 'd' 
  ),);


#
# Add StratusLab authentification service
#
include { 'stratuslab/one-proxy/config' };

