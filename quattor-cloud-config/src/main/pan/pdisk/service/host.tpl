unique template pdisk/service/host;

include { 'pdisk/rpms/host' };

# 
# Modify sudo configuration to allow oneadmin to use the 
# scripts for mounting and unmouning iscsi volumes.
#
include { 'components/sudo/config' };

#root    ALL=(ALL) ALL
#tomcat  ALL=(GLEXEC_ACCOUNTS) NOPASSWD: GLEXEC_CMDS
'/software/components/sudo/privilege_lines' = 
  append(
    nlist('user', 'oneadmin',
          'run_as', 'ALL',
          'host', 'ALL',
          'options', 'NOPASSWD',
          'cmd', '/usr/sbin/attach-persistent-disk.sh, /usr/sbin/detach-persistent-disk.sh'),
  );
