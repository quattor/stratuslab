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

unique template one/service/nfs-exports;

#
# Start the NFS daemons at boot. 
#
include {'components/chkconfig/config'};
'/software/components/chkconfig/service/nfs' = nlist('on', '', 'startstop', true);

#
# Export the image repository, VM state area, and oneadmin home.
#
# Use **filecopy component** here because the NFS component can't handle
# wildcards or slashes in IP addresses.
#
include { 'components/filecopy/config' };

variable ONE_NFS_FLAGS = {
   ok = first(ONE_NFS_WILDCARD,k,v);
   one_nfs_flags = "";
   while (ok) {
        if ( one_nfs_flags == "" ) {
          one_nfs_flags =  v +'(async,no_subtree_check,rw,no_root_squash)';
        } else {
          one_nfs_flags =  one_nfs_flags + " " + v +'(async,no_subtree_check,rw,no_root_squash)';
        };
        ok = next(ONE_NFS_WILDCARD, k, v);
   };
   return (one_nfs_flags+ "\n");
 # ONE_NFS_WILDCARD + '(async,no_subtree_check,rw,no_root_squash)' + "\n";
};

variable ONE_NFS_EXPORT_CONTENTS =
'/var/lib/one ' + ONE_NFS_FLAGS +
'/home/oneadmin ' + ONE_NFS_FLAGS;

'/software/components/filecopy/services/{/etc/exports}' = nlist(
  'config', ONE_NFS_EXPORT_CONTENTS,
  'owner', 'root',
  'group', 'root',
  'perms', '0644',
  'restart', 'service nfs restart'
);

#
# Configure firewall for NFS services.
#

include { 'components/iptables/config' };

# NFS ports must be defined explicitly.
variable ONE_NFS_PORTS ?= nlist(
  'tcp', list('111', '662', '875', '892', '2049', '32803'),
  'udp', list('111', '662', '875', '892', '32769'),
);
variable ONE_NFS_CONF ?= '/etc/sysconfig/nfs';
variable ONE_NFS_CONF_CONTENT ?= <<EOF;
LOCKD_TCPPORT=32803
LOCKD_UDPPORT=32769
MOUNTD_PORT=892
RQUOTAD_PORT=875
STATD_PORT=662
STATD_OUTGOING_PORT=2020
EOF

'/software/components/filecopy/services/' = npush(
  escape(ONE_NFS_CONF), nlist(
    'config', ONE_NFS_CONF_CONTENT,
    'owner', 'root',
    'group', 'root',
    'perms', '0644',
    'restart', 'service nfs restart; service rpcbind restart; service rpcsvcgssd restart'
  ),
);

'/software/components/iptables/filter/rules' = {
  foreach(proto; ports; ONE_NFS_PORTS) {
    foreach(idx; port; ports) {
      append(nlist(
        'command', '-A',
        'chain', 'INPUT',
        'protocol', proto,
        'match', proto,
        'dst_port', port,
        'target', 'ACCEPT'
      ));
    };
  };
};

