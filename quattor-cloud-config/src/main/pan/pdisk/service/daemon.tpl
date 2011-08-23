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

include { 'pdisk/rpms/daemon' };

#
# Activate the daemon at boot.
#
include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/pdisk/on'  = '';

#
# Write the configuration file with filecopy for the moment.
#
#include { 'components/filecopy/config' };
#'/software/components/filecopy/services/{/etc/stratuslab/pdisk.cfg}' = 
#  nlist('config',file_contents('pdisk/service/daemon.cfg'),
#        'restart','service pdisk restart',
#        'perms','0644');

#
# Write the configuration file with filecopy for the moment.
#
include { 'components/filecopy/config' };
'/software/components/filecopy/services/{/etc/stratuslab/storage/pdisk/login.conf}' =
  nlist('config',file_contents('pdisk/service/login.conf'),
        'restart','service pdisk restart',
        'perms','0644');

