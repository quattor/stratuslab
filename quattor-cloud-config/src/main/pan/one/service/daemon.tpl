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
# Start the OpenNebula daemon (oned) at boot. 
#
include {'components/chkconfig/config'};
'/software/components/chkconfig/service/oned' = nlist('on', '', 'startstop', true);

#
# Configure OpenNebula daemon.
#
include { 'components/oned/config' };

#
# Monitoring delays are appropriate for small/testing systems.
# Change to longer delays for production systems.
#
'/software/components/oned/daemon/HOST_MONITORING_INTERVAL' = ONE_MONITOR_INTERVAL;
'/software/components/oned/daemon/VM_POLLING_INTERVAL' = ONE_POLLING_INTERVAL;

#
# Define all of the standard plug-ins for OpenNebula. 
# Assumes that KVM is being used on the site.
#
'/software/components/oned/mads/im_kvm' = nlist(
    'manager', 'IM',
    'executable', 'one_im_ssh',
    'arguments', 'kvm'
  );

'/software/components/oned/mads/vmm_kvm' = nlist(
    'manager', 'VM',
    'executable', 'one_vmm_ssh',
    'arguments', 'kvm',
    'default', 'vmm_ssh/vmm_ssh_kvm.conf',
    'type', 'kvm'
  );

'/software/components/oned/mads/tm_nfs' = nlist(
    'manager', 'TM',
    'executable', 'one_tm',
    'arguments', 'tm_nfs/tm_nfs.conf'
  );

'/software/components/oned/mads/tm_ssh' = nlist(
    'manager', 'TM',
    'executable', 'one_tm',
    'arguments', 'tm_ssh/tm_ssh.conf'
  );

'/software/components/oned/mads/hm' = nlist(
    'manager', 'HM',
    'executable', 'one_hm'
  );

'/software/components/oned/mads/auth' = nlist(
    'manager', 'AUTH',
    'executable', 'one_external_authn_mad'
  );

'/software/components/oned/hooks/image' = nlist(
    'on', 'DONE',
    'command', '/usr/share/one/hooks/image.rb',
    'arguments', '$VMID'
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
