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

unique template stratuslab/pdisk/host/config;

include { 'stratuslab/pdisk/rpms/host' };

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
          'options', 'NOPASSWD',
 #         'cmd'    , '/sbin/iscsiadm, /usr/sbin/detach-persistent-disk.sh, /usr/bin/virsh, /usr/sbin/attach-persistent-disk.sh'),
          'cmd'    , 'ALL'),
  );

  include { 'stratuslab/pdisk/host/config-file' };
