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

unique template marketplace/service/daemon;

include { 'marketplace/rpms/daemon' };

include { 'marketplace/variables' };

include { 'marketplace/service/mysql' };
#
# Activate the daemon at boot.
#
include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/marketplace/on'  = '';

#
# Write the configuration file with filecopy for the moment.
#

include { 'components/filecopy/config' };
'/software/components/filecopy/services/{/etc/stratuslab/marketplace.cfg}' = 
  nlist('config',format(file_contents('marketplace/service/daemon.cfg'),
                                      STRATUSLAB_MARKETPLACE_ADMIN_EMAIL,
                                      STRATUSLAB_MARKETPLACE_MAIL_HOST,
                                      STRATUSLAB_MARKETPLACE_MAIL_PORT,
                                      STRATUSLAB_MARKETPLACE_MAIL_USER,
                                      STRATUSLAB_MARKETPLACE_MAIL_PWD,
                                      STRATUSLAB_MARKETPLACE_MAIL_SSL,
                                      STRATUSLAB_MARKETPLACE_MAIL_DEBUG,
                                      STRATUSLAB_MARKETPLACE_DATA_DIR,
                                      STRATUSLAB_MARKETPLACE_PENDING_DIR,
                                      STRATUSLAB_MARKETPLACE_VALIDATE_EMAIL,
                                      STRATUSLAB_MARKETPLACE_DB_NAME,
                                      STRATUSLAB_MARKETPLACE_DB_USER,
                                      STRATUSLAB_MARKETPLACE_DB_USER_PWD,
                 ),
        'restart','service marketplace restart',
        'perms','0644');


include { 'components/iptables/config' };

'/software/components/iptables/filter/rules' = {
# SSH port
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'protocol', 'tcp',
    'match', 'tcp',
    'dst_port', '8081',
    'target', 'ACCEPT',
  ));
# OpenNebula port
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'protocol', 'tcp',
    'match', 'tcp',
    'source', '127.0.0.1',
    'dst_port', '3306',
    'target', 'ACCEPT'
  ));
};
