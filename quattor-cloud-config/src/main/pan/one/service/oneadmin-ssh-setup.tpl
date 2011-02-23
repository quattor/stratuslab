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

unique template one/service/oneadmin-ssh-setup;

#
# Use filecopy to get the oneadmin ssh keys into place.  This generates
# a new ssh key-pair (if necessary) and adds the public key to the 
# authorized key files.  
#
variable SSH_SETUP_SCRIPT = 
  'rm -f /home/oneadmin/.ssh/id_rsa* /home/oneadmin/.ssh/authorized*; ' +
  'ssh-keygen -f /home/oneadmin/.ssh/id_rsa -t rsa -N '''' -q; ' +
  'cp /home/oneadmin/.ssh/id_rsa.pub /home/oneadmin/.ssh/authorized_keys; ' + 
  'cp /home/oneadmin/.ssh/id_rsa.pub /home/oneadmin/.ssh/authorized_keys2; ' + 
  'chown -R oneadmin:cloud /home/oneadmin/.ssh';

#
# The trigger for the configuration is the ~/.ssh/config file.  Ensure that
# the strict host checking is not done so that initial connections are not
# blocked with an interactive prompt.
#  
include { 'components/filecopy/config' };
'/software/components/filecopy/services/{/home/oneadmin/.ssh/config}' = nlist(
  'config', "Host *\n    StrictHostKeyChecking no\n",
  'owner', 'oneadmin',
  'group', 'cloud',
  'perms', '0600',
  'restart', SSH_SETUP_SCRIPT,
  'backup', false,
  'forceRestart', false
);
