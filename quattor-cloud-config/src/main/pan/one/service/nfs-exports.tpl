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

variable ONE_NFS_FLAGS = 
  ONE_NFS_WILDCARD + '(async,no_subtree_check,rw,no_root_squash)' + "\n";

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

