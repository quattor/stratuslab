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

unique template one/service/onevnet-config;

include { 'components/filecopy/config' };

'/software/components/filecopy/services/{/home/oneadmin/private.net}' =
  nlist('config', STRATUSLAB_PRIVATE_NETWORK_CONFIG,
        'owner', 'root',
        'perms', '0644',
        'restart', 'su - oneadmin -c "onevnet create /home/oneadmin/private.net"',
       );

'/software/components/filecopy/services/{/home/oneadmin/local.net}' =
  nlist('config', STRATUSLAB_LOCAL_NETWORK_CONFIG,
        'owner', 'root',
        'perms', '0644',
        'restart', 'su - oneadmin -c "onevnet create /home/oneadmin/local.net"',
       );

'/software/components/filecopy/services/{/home/oneadmin/public.net}' =
  nlist('config', STRATUSLAB_PUBLIC_NETWORK_CONFIG,
        'owner', 'root',
        'perms', '0644',
        'restart', 'su - oneadmin -c "onevnet create /home/oneadmin/public.net"',
       );



