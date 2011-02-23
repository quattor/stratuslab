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

unique template one/service/common-config;

include { 'machine-types/nfs' };

# Create the 'oneadmin' user and 'cloud' group for OpenNebula.
'/software/components/accounts/groups/cloud/gid' = 9000;
'/software/components/accounts/users/oneadmin' = nlist(
  'uid', 9000,
  'groups', list('cloud'),
  'homeDir', '/home/oneadmin',
  'createHome', false,
  'createKeys', false
);

# Configure libvirtd.
include {'components/libvirtd/config' };

'/software/components/libvirtd/network/listen_tcp' = 1;
'/software/components/libvirtd/socket/unix_sock_group' = 'cloud';
'/software/components/libvirtd/socket/unix_sock_ro_perms' = '0777';
'/software/components/libvirtd/socket/unix_sock_rw_perms' = '0770';
'/software/components/libvirtd/authn/auth_unix_ro' = 'none';
'/software/components/libvirtd/authn/auth_unix_rw' = 'none';

# Control various sysctl variables for the networking.
include { 'components/sysctl/config' };

'/software/components/sysctl/variables/net.ipv4.ip_forward' = '1';
'/software/components/sysctl/variables/net.bridge.bridge-nf-call-ip6tables' = '0';
'/software/components/sysctl/variables/net.bridge.bridge-nf-call-iptables' = '0';
'/software/components/sysctl/variables/net.bridge.bridge-nf-call-arptables' = '0';

# Setup the networking.
'/system/network/interfaces/br0' = nlist(
  'device', 'br0',
  'set_hwaddr', false,
  'type', 'Bridge',
  'bootproto', 'static',
  'onboot', 'yes',
  'ip', DB_IP[escape(FULL_HOSTNAME)], 
  'netmask', '255.255.254.0'  
);

'/system/network/interfaces/eth0' = nlist(
  'device', 'eth0',
  'set_hwaddr', true,
  'onboot', 'yes',
  'bridge', 'br0',
  'bootproto', ' ' # component defaults to static but want nothing!
);

