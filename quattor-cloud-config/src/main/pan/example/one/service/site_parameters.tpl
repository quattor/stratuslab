unique template one/service/site_parameters;

#
# Mail configuration used for services
#

variable STRATUSLAB_MAIL_EMAIL ?= '';
variable STRATUSLAB_MAIL_HOST ?= '';
variable STRATUSLAB_MAIL_USER ?= 'no-reply@stratuslab.eu';
variable STRATUSLAB_MAIL_USER_PWD ?= '';

#
# Persistent disk variable (server host, super user pwd, storage device)
#
variable STRATUSLAB_PDISK_HOST ?= 'onehost-7.lal.in2p3.fr';
variable STRATUSLAB_PDISK_SUPER_USER_PWD ?= '';
variable STRATUSLAB_PDISK_DEVICE ?= '/dev/vg.02';

#
# ldap authentification based variable
#
variable STRATUSLAB_LDAP_HOST     ?= 'ldap.stratuslab.eu';
variable STRATUSLAB_LDAP_BIND_PWD ?= 'jetty7109';

#
# Full hostname of NFS server, usually OpenNebula front-end.
#
variable ONE_NFS_SERVER ?= 'onehost-4.lal.in2p3.fr';
variable ONE_NFS_SERVER_VAR ?= 'onehost-7.lal.in2p3.fr';
variable ONE_NFS_WILDCARD ?= list('134.158.75.0/24');

#
# Ganglia variables
#
variable GANGLIA_MASTER ?= '134.158.75.4';

#
# Marketplace endpoint
#
variable STRATUSLAB_MARKETPLACE_HOST ?= 'marketplace.stratuslab.eu';


#
# Local network configuration
#
variable PRIVATE_MASTER_INT ?= 'eth0';
variable PRIVATE_NET        ?= '192.168.16.0/24';
variable PRIVATE_IP         ?= '192.168.16.1';
variable PRIVATE_NETMASK    ?= '255.255.255.0';

#
# Registration service configuration
#
variable STRATUSLAB_REGISTRATION_LDAP_MANAGER_PWD ?= '';

#
# Mysql configuration variables
#
variable ONE_SQL_BACKEND ?= 'mysql';
variable MYSQL_PASSWORD ?= '';

#
# List of Stratuslab node
#

variable STRATUSLAB_NODE_LIST ?= list(
	'onehost',
);

#########################
# Network configuration #
#########################
variable ONE_NETWORK = nlist(
'domain','lal.in2p3.fr',
'nameserver', list('134.158.91.80'),
'public', nlist(
		 'interface', 'br0',
		 'subnet', '134.158.75.0',
		 'router', '134.158.75.1',
		 'netmask', '255.255.255.0',
		 'vms',nlist(
			'onevm-239',nlist('mac-address','0a:0a:86:9e:49:ef','fixed-address','134.158.75.239','claudia','no'),
			),
		),
'local',nlist(
		'interface', 'br0:privlan',
		'subnet',  '192.168.16.0',
		'router',  '192.168.16.4',
		'netmask', '255.255.255.0',
		'vms',nlist(
			'onevmp-239',nlist('mac-address','0a:0a:86:9e:50:ef','fixed-address','192.168.16.239','claudia','no')
			),
		),
);
