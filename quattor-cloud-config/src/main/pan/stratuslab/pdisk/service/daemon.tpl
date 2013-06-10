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

unique template stratuslab/pdisk/service/daemon;

include { 'stratuslab/pdisk/variables' };
include { 'stratuslab/pdisk/rpms/'+STRATUSLAB_SPMA_VERSION+'/daemon' };

#
# Activate the daemon at boot.
#
include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/pdisk/on'  = '';
'/software/components/chkconfig/service/tgtd/on'  = '';

#
# Write the configuration file with filecopy for the moment.
#
include { 'components/filecopy/config' };
'/software/components/filecopy/services/{/etc/stratuslab/pdisk.cfg}' = 
  nlist('config',format(file_contents('stratuslab/pdisk/service/daemon.cfg'),
                 STRATUSLAB_PDISK_SSH_KEY,
                 STRATUSLAB_PDISK_SSH_USER,
                 STRATUSLAB_PDISK_VM_DIR,
                 STRATUSLAB_PDISK_SUPER_USER,
                 STRATUSLAB_PDISK_NFS_LOCATION,
                 STRATUSLAB_PDISK_CACHE_LOCATION,
                 STRATUSLAB_PDISK_UTILS_GZIP,
                 STRATUSLAB_PDISK_UTILS_GUNZIP,
                 STRATUSLAB_PDISK_ISCSI_TYPE,
                 STRATUSLAB_PDISK_PROXY_LOCATION,
        ),
        'restart','service pdisk restart',
        'perms','0644');

'/software/components/filecopy/services/{/etc/tgt/targets.conf}'=
  nlist('config',"default-driver iscsi\ninclude /etc/stratuslab/iscsi.conf",
        'perms' ,'0644',
        'restart', 'service tgtd restart',
  );

include { 'stratuslab/pdisk/service/pdisk-backend' };

include { 'components/one_proxy/config' };

'/software/components/one_proxy/daemon'=append('pdisk');

#
# Add iptables configuration
#
include { 'components/iptables/config' };

'/software/components/iptables/filter/rules' = {
    append(nlist(
        'command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'dst_port', '8445',
        'target', 'ACCEPT'
    ));
    append(nlist(
        'command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'dst_port', '2181',
        'target', 'ACCEPT'
    ));
  append(nlist(
        'command', '-A',
        'chain', 'INPUT',
        'protocol', 'udp',
        'match', 'udp',
        'dst_port', '3260',
        'target', 'ACCEPT'
    ));
  append(nlist(
        'command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'dst_port', '3260',
        'target', 'ACCEPT'
    ));
};
