unique template stratuslab/pdisk/host/config;

'/software/packages/{stratuslab-pdisk-host}' ?= nlist();
'/software/packages/{iscsi-initiator-utils}' ?= nlist();
# 
# Modify sudo configuration to allow oneadmin to use the 
# scripts for mounting and unmouning iscsi volumes.
#
include { 'components/sudo/config' };

#root    ALL=(ALL) ALL
#tomcat  ALL=(GLEXEC_ACCOUNTS) NOPASSWD: GLEXEC_CMDS
'/software/components/sudo/privilege_lines' = 
  append(
    nlist('user'   , 'oneadmin',
          'run_as' , 'ALL',
          'host'   , 'ALL',
          'options', 'NOPASSWD:',
          'cmd'    , 'ALL'),
  );
  
include { 'stratuslab/pdisk/host/config-file' };

include { 'components/dirperm/config' };
prefix '/software/components/dirperm';
'paths' = {
  SELF[length(SELF)] = nlist(
    'owner','oneadmin:cloud',
    'path', '/var/run/stratuslab',
    'perm', '0755',
    'type', 'd',
  );
  SELF;
};
