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

unique template stratuslab/one/service/node-config;


# Configure libvirtd.
include {'components/libvirtd/config' };

'/software/components/libvirtd/network/listen_tcp' = 1;
'/software/components/libvirtd/socket/unix_sock_group' = 'cloud';
'/software/components/libvirtd/socket/unix_sock_ro_perms' = '0777';
'/software/components/libvirtd/socket/unix_sock_rw_perms' = '0770';
'/software/components/libvirtd/authn/auth_unix_ro' = 'none';
'/software/components/libvirtd/authn/auth_unix_rw' = 'none';

include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/libvirtd/on' = '345';
'/software/components/chkconfig/service/libvirtd/startstop' = true;

include { if_exists('fixes/qemu-kvm') };

# Configure system properties.
include { 'components/sysctl/config' };

'/software/components/sysctl/variables/net.ipv4.ip_forward' = '1';
'/software/components/sysctl/variables/net.bridge.bridge-nf-call-ip6tables' = '0';
'/software/components/sysctl/variables/net.bridge.bridge-nf-call-iptables' = '0';
'/software/components/sysctl/variables/net.bridge.bridge-nf-call-arptables' = '0';


# Setup the networking.
include { 'components/network/config' };

variable STRATUSLAB_BR_INTERFACE ?= boot_nic();

'/system/network/default_gateway' = NETWORK_PARAMS['gateway'];
'/system/network/interfaces/br0' = nlist(
  'device', 'br0',
  'set_hwaddr', false,
  'type', 'Bridge',
  'bootproto', 'static',
  'onboot', 'yes',
  'ip', value("/system/network/interfaces/" + STRATUSLAB_BR_INTERFACE + "/ip"),
  'netmask', value("/system/network/interfaces/" + STRATUSLAB_BR_INTERFACE + "/netmask"),
);

'/system/network/interfaces' = {
    SELF[STRATUSLAB_BR_INTERFACE]=nlist(
	'device', STRATUSLAB_BR_INTERFACE,
	'set_hwaddr', true,
	'onboot', 'yes',
	'bridge', 'br0',
	'bootproto', ' ' # component defaults to static but want nothing!
    );
    SELF;
};
