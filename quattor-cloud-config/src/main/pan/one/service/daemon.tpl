# ${BUILD_INFO}
#
# Created as part of the StratusLab project (http://stratuslab.eu)
#
# Copyright (c) 2010-2011, Centre National de la Recherche Scientifique
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unique template one/service/daemon;

#
# Include script for sl6 support
#
include { 'one/service/vmm_exec_kvm_sl6' };

#
# Start the OpenNebula daemon (oned) at boot. 
#
include {'components/chkconfig/config'};
'/software/components/chkconfig/service/oned' = nlist('on', '', 'startstop', true);

#
# Configure OpenNebula daemon.
#
include { 'components/oned/config' };

prefix '/software/components/oned';
#
# Monitoring delays are appropriate for small/testing systems.
# Change to longer delays for production systems.
#
'daemon/HOST_MONITORING_INTERVAL' = ONE_MONITOR_INTERVAL;
'daemon/VM_POLLING_INTERVAL' = ONE_POLLING_INTERVAL;

#
# Define all of the standard plug-ins for OpenNebula. 
# Assumes that KVM is being used on the site.
#
'mads/im_kvm' = nlist(
    'manager', 'IM',
    'executable', 'one_im_ssh',
    'arguments', '-r 0 -t 15 kvm'
  );

'mads/vmm_kvm' = nlist(
    'manager', 'VM',
    'executable', 'one_vmm_exec',
    'arguments', '-t 15 -r 0 kvm',
    'default', 'vmm_exec/vmm_exec_kvm.conf',
    'type', 'kvm'
  );

'mads/vmm_kvm_sl6' = nlist(
    'manager', 'VM',
    'executable', 'one_vmm_exec',
    'arguments', '-t 15 -r 0 kvm',
    'default', 'vmm_exec/vmm_exec_kvm_sl6.conf',
    'type', 'kvm'
);

'mads/tm_stratuslab' = nlist(
    'manager', 'TM',
    'executable', 'one_tm',
    'arguments', 'tm_stratuslab/tm_stratuslab.conf'
  );

'mads/tm_shared' = nlist(
    'manager', 'TM',
    'executable', 'one_tm',
    'arguments', 'tm_shared/tm_shared.conf'
  );

'mads/hm' = nlist(
    'manager', 'HM',
    'executable', 'one_hm'
  );

'mads/image' = nlist(
   'manager', 'IMAGE',
   'executable', 'one_image',
   'arguments', 'fs -t 15',
);

'mads/auth' = nlist(
    'manager', 'AUTH',
    'executable', 'one_auth_mad',
    'arguments', '--authz quota --authn dummy,plain,default',
  );

'hooks/done' = nlist(
    'on', 'DONE',
    'command', '/usr/share/one/hooks/notify.rb',
    'arguments', '$VMID DONE',
    'remote', 'NO',
  );

'hooks/create' = nlist(
    'on', 'CREATE',
    'command', '/usr/share/one/hooks/notify.rb',
    'arguments', '$VMID CREATE',
    'remote', 'NO',
  );

'hooks/running' = nlist(
    'on', 'RUNNING',
    'command', '/usr/share/one/hooks/notify.rb',
    'arguments', '$VMID RUNNING',
    'remote', 'NO',
  );



variable INITD_ONED = <<EOF;
#!/bin/bash
#
# oned -- OpenNebula Daemon
#
# chkconfig: 2345 99 30
# description: OpenNebula is a Virtual Infrastructure Manaager
# processname: oned
# config: /srv/cloud/one/etc/oned.conf
#

# Source function library.
. /etc/rc.d/init.d/functions

RETVAL=0
prog="oned"
daemonexe="/usr/bin/oned"
ctrlexe="/usr/bin/one"
one_user="oneadmin"

[ -x ${ctrlexe} ] || exit 0
[ -x ${daemonexe} ] || exit 0

start() {
  # Start the OpenNebula daemon
  echo -n $"Starting OpenNebula (${prog}): "
  su - ${one_user} -c "${ctrlexe} start" 2>/dev/null 1>&2 && success || failure $"$prog start"
  RETVAL=$?
  echo
  return $RETVAL
}

stop() {
  # Stop the OpenNebula daemon
  echo -n $"Shutting down OpenNebula (${prog}): "
  su - ${one_user} -c "${ctrlexe} stop" 2>/dev/null 1>&2 && success || failure $"$prog start"
  RETVAL=$?
  echo
  return $RETVAL
}

restart() {
  stop
  start
}

mystatus() {
  status -p /var/run/one/oned.pid oned
  status -p /var/run/one/sched.pid mm_sched
}

# See how we were called.
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart)
        restart
        ;;
  status)
        mystatus
        ;;
  *)
        echo $"Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit $?
EOF

#"/software/components/filecopy/services" = npush(
#        escape("/etc/init.d/oned"),
#        nlist("config",INITD_ONED,
#                "owner","root",
#                "group","root",
#                "perms","0755",));
##               "restart","service libvirtd restart"));
