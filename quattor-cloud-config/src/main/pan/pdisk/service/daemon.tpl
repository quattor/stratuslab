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

unique template pdisk/service/daemon;

include { 'pdisk/variables' };
include { 'pdisk/rpms/daemon' };

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
  nlist('config',format(file_contents('pdisk/service/daemon.cfg'),
                 STRATUSLAB_PDISK_TYPE,
                 STRATUSLAB_PDISK_USER_PER_PDISK,
                 STRATUSLAB_PDISK_SSH_KEY,
                 STRATUSLAB_PDISK_SSH_USER,
                 STRATUSLAB_PDISK_VM_DIR,
                 STRATUSLAB_PDISK_SUPER_USER,
                 STRATUSLAB_PDISK_NFS_LOCATION,
                 STRATUSLAB_PDISK_ISCSI_TYPE,
                 STRATUSLAB_PDISK_ISCSI_FILE_LOCATION,
                 STRATUSLAB_PDISK_ISCSI_CONF,
                 STRATUSLAB_PDISK_ISCSI_ADMIN,
                 STRATUSLAB_PDISK_DEVICE,
                 STRATUSLAB_PDISK_LVM_VGDISPLAY,
                 STRATUSLAB_PDISK_LVM_CREATE,
                 STRATUSLAB_PDISK_LVM_REMOVE,
                 STRATUSLAB_PDISK_LVM_CHANGE,
                 STRATUSLAB_PDISK_LVM_DMSETUP,
                 STRATUSLAB_PDISK_ZOOKEEPER_URI
        ),
        'restart','service pdisk restart',
        'perms','0644');

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
