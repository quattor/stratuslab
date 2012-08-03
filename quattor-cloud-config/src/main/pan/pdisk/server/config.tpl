unique template pdisk/server/config;

include { 'config/stratuslab/base' };

#
# Include general parameters for StratusLab
#

include { 'stratuslab/default/parameters' };
include { 'pdisk/variables' };

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
include { 'pdisk/service/daemon' };
include { 'iscsi/rpms/target' };

#
# Include shared fs configuration
#
include { 'common/nfs/nfs-exports' };
include { 'common/nfs/nfs-imports' };

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


#
# Sudo configuration to allow --save option
#

include { 'pdisk/server/sudo' };

#
# Add StratusLab authentification service
#
include { 'stratuslab/one-proxy/config' };

