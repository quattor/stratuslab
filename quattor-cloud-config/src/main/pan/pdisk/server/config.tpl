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
# Add StratusLab authentification service
#
include { 'stratuslab/one-proxy/config' };

