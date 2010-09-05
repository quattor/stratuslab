${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/one-common-config;

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

