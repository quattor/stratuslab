unique template one/service/site_parameters;

#
# Full hostname of NFS server, usually OpenNebula front-end.
#
variable ONE_NFS_SERVER = 'onehost-2.lal.in2p3.fr';
variable STRATUSLAB_PDISK_HOST ?= 'onehost-2.lal.in2p3.fr';
variable STRATUSLAB_PDISK_SUPER_USER_PWD ?= 'mypassword';
variable STRATUSLAB_PDISK_DEVICE ?= '/dev/vg.02';
variable STRATUSLAB_PDISK_TYPE ?= 'iscsi';
variable STRATUSLAB_PDISK_ISCSI_TYPE ?= 'lvm';

variable STRATUSLAB_IPV6_ENABLE ?= true;
variable STRATUSLAB_ONE_IPV6_PREFIX ?= '2001:660:3024:101::/64';

#
# An NFS wildcard that includes all of the OpenNebula nodes.
#
variable ONE_NFS_WILDCARD = list('134.158.75.0/24');

#
# StratusLab nodes definition.
#
# The variable STRATUSLAB_NODE_LIST can be either a list or a nlist. In
# the first case, the default parameters will be applied to all nodes.
# In the second case, node names are the keys and node parameters are
# the values. Special value 'DEFAULT' can be used to applied default
# parameters.
#
# For example:
#   variable STRATUSLAB_NODE_LIST ?= nlist(
#       'onehost-01.example.org', 'DEFAULT',
#       'onehost-02.example.org', nlist('vnm_mad', '802.1Q'),
#       'onehost-03.example.org', nlist('vnm_mad', '802.1Q', 'tm_mad', 'tm_ssh'),
#   };
#
variable STRATUSLAB_NODE_LIST ?= list(
	'onehost-10.lal.in2p3.fr',
);

#
# Ganglia variables
#
variable GANGLIA_MASTER = '134.158.75.2';

variable ONE_SQL_BACKEND ?= 'mysql';
variable MYSQL_PASSWORD ?= 'root';
variable STRATUSLAB_ONE_PASSWORD ?= 'Password_one_home_oneadmin_.one_oneauth';

variable ONE_NETWORK = nlist(
'domain','lal.in2p3.fr',
'nameserver', list('134.158.91.80'),
'public', nlist(
     'interface', 'br0',
     'subnet', '134.158.75.0',
     'router', '134.158.75.1',
     'netmask', '255.255.255.0',
     'vms',nlist(
      'onevm-32',nlist('mac-address','0a:0a:86:9e:49:20','fixed-address','134.158.75.32'),
      'onevm-33',nlist('mac-address','0a:0a:86:9e:49:21','fixed-address','134.158.75.33'),
      'onevm-34',nlist('mac-address','0a:0a:86:9e:49:22','fixed-address','134.158.75.34'),
      'onevm-35',nlist('mac-address','0a:0a:86:9e:49:23','fixed-address','134.158.75.35'),
      'onevm-36',nlist('mac-address','0a:0a:86:9e:49:24','fixed-address','134.158.75.36'),
      'onevm-37',nlist('mac-address','0a:0a:86:9e:49:25','fixed-address','134.158.75.37'),
      'onevm-38',nlist('mac-address','0a:0a:86:9e:49:26','fixed-address','134.158.75.38'),
      'onevm-39',nlist('mac-address','0a:0a:86:9e:49:27','fixed-address','134.158.75.39'),
#     'onevm-40',nlist('mac-address','0a:0a:86:9e:49:28','fixed-address','134.158.75.40'),
#     'onevm-41',nlist('mac-address','0a:0a:86:9e:49:29','fixed-address','134.158.75.41')
      ),
    ),
'local',nlist(
    'interface', 'br0:privlan',
    'subnet',  '172.17.16.0',
    'router',  '172.17.16.1',
    'netmask', '255.255.255.0',
    'vms',nlist(
      'onevmp-32',nlist('mac-address','0a:0b:86:9e:49:20','fixed-address','172.17.16.32'),
            'onevmp-33',nlist('mac-address','0a:0b:86:9e:49:21','fixed-address','172.17.16.33'),
            'onevmp-34',nlist('mac-address','0a:0b:86:9e:49:22','fixed-address','172.17.16.34'),
            'onevmp-35',nlist('mac-address','0a:0b:86:9e:49:23','fixed-address','172.17.16.35'),
            'onevmp-36',nlist('mac-address','0a:0b:86:9e:49:24','fixed-address','172.17.16.36'),
            'onevmp-37',nlist('mac-address','0a:0b:86:9e:49:25','fixed-address','172.17.16.37'),
            'onevmp-38',nlist('mac-address','0a:0b:86:9e:49:26','fixed-address','172.17.16.38'),
            'onevmp-39',nlist('mac-address','0a:0b:86:9e:49:27','fixed-address','172.17.16.39'),
#           'onevmp-40',nlist('mac-address','0a:0b:86:9e:49:28','fixed-address','172.17.16.40'),
#           'onevmp-41',nlist('mac-address','0a:0b:86:9e:49:29','fixed-address','172.17.16.41')
      ),
    ),
);
