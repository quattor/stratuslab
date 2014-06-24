unique template stratuslab/one/variables;

include { 'stratuslab/default/parameters' };

#
# OpenNebula files and directories.
#
variable ONE_SERVICE ?= 'oned';
variable ONE_HOOKS_DIR ?= '/usr/share/one/hooks/';

#
# Monitoring internal in seconds.  Increase this value for
# a production system.
#
variable ONE_MONITOR_INTERVAL ?= 30;

#
# VM polling interval in seconds.  Increase this value for
# a production system.
#
variable ONE_POLLING_INTERVAL ?= 30;

#
# Backend variables
#
variable ONE_SQL_BACKEND ?= 'mysql';

# 
# Quotas
#
variable ONE_CPU_QUOTA ?= 20.0;
variable ONE_RAM_KB_QUOTA ?= 41943040;

variable STRATUSLAB_ONE_HOST ?= '';
variable STRATUSLAB_ONE_USERNAME ?= STRATUSLAB_UNIX_USER_ACCOUNT;
variable STRATUSLAB_ONE_PASSWORD ?= 'STRATUSLAB_ONE_PASSWORD should_be_modify_after_installation';
variable STRATUSLAB_ONE_PORT ?= '2633';
variable STRATUSLAB_ONE_IPV6_PREFIX ?= if (STRATUSLAB_IPV6_ENABLE) {
	error('You need to have a IPV6_PREFIX');
} else {
	  '';
};
