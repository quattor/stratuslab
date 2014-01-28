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

include { 'stratuslab/default/parameters' };

# Configure libvirtd.
include {'components/libvirtd/config' };

prefix '/software/components/libvirtd';
'network/listen_tcp'        = 1;
'socket/unix_sock_group'    = 'cloud';
'socket/unix_sock_ro_perms' = '0777';
'socket/unix_sock_rw_perms' = '0770';
'authn/auth_unix_ro'        = 'none';
'authn/auth_unix_rw'        = 'none';

variable QEMU_CONF = 'user = "' + STRATUSLAB_UNIX_USER_ACCOUNT + '"\n';
variable QEMU_CONF = QEMU_CONF + 'group = "' + STRATUSLAB_UNIX_GROUP + '"\n';
variable QEMU_CONF = QEMU_CONF + 'dynamic_ownership = 1\n';

'/software/components/filecopy/services' = npush(
	escape('/etc/libvirt/qemu.conf'), nlist(
        'config', QEMU_CONF,
		'owner', 'root',
		'group', 'root',
		'perms', '0644',
		'restart', 'service libvirtd restart',
    )
);

include { 'components/chkconfig/config' };
prefix '/software/components/chkconfig/service';
'libvirtd/on' = '345';
'libvirtd/startstop' = true;

include { if_exists('fixes/qemu-kvm') };

# Configure system properties.
include { 'components/sysctl/config' };

prefix '/software/components/sysctl/variables';
'net.ipv4.ip_forward'                 = '1';
'net.bridge.bridge-nf-call-ip6tables' = '0';
'net.bridge.bridge-nf-call-iptables'  = '0';
'net.bridge.bridge-nf-call-arptables' = '0';


# Setup the networking.
include { 'components/network/config' };

'/system/network/default_gateway' = NETWORK_PARAMS['gateway'];
'/system/network/interfaces/br0' = nlist(
  'device', 'br0',
  'set_hwaddr', false,
  'type', 'Bridge',
  'bootproto', 'static',
  'onboot', 'yes',
  'ip', NETWORK_PARAMS['ip'],
  'netmask', NETWORK_PARAMS['netmask'],
);

'/system/network/interfaces' = {
  eth_name = boot_nic();
  SELF[eth_name]=nlist(
    'device', eth_name,
    'set_hwaddr', true,
    'onboot', 'yes',
    'bridge', 'br0',
    'bootproto', ' ' # component defaults to static but want nothing!
  );
  SELF;
};

include {
  if ( exists(ONE_VLAN_ENABLE) && ONE_VLAN_ENABLE ) {
    'common/network/vlan/config';
  } else {
    null;
  };
};
