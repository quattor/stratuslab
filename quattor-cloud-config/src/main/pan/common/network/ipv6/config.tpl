unique template common/network/ipv6/config;

'/software/components/network/active'=false;

function _ipv4tov6 = { 
   ipv4=ARGV[0];
   ids = replace('\.',':',ipv4);
   ipv6_prefix = split('/',STRATUSLAB_ONE_IPV6_PREFIX);
   ipv6 = replace('::','',ipv6_prefix[0])+":"+ids;
   ipv6;
};

variable _STRATUSLAB_INTERFACE_NAME ?= {
	if( exists('/system/network/interfaces/br0')) {
		"br0";
	} else {
		boot_nic();
	};
};

variable _STRATUSLAB_IPV4_ADDRESS ?= {
	DB_IP[escape(FULL_HOSTNAME)];
};

variable _STRATUSLAB_IPV6_ADDRESS ?= {
	_ipv4tov6(_STRATUSLAB_IPV4_ADDRESS);
};

variable _STRATUSLAB_HW_ADDRESS = value('/hardware/cards/nic/'+boot_nic()+'/hwaddr');

variable _STRATUSLAB_IPV4_NETMASK ?= {
	NETWORK_PARAMS['netmask']
};

variable _STRATUSLAB_IPV4_GATEWAY ?= {
	NETWORK_DEFAULT_GATEWAY;
};

variable _STRATUSLAB_IPV6_GATEWAY ?= {
	_ipv4tov6(_STRATUSLAB_IPV4_GATEWAY);
};

include { 'components/filecopy/config' };

prefix '/software/components';

'filecopy/services'= if ( _STRATUSLAB_INTERFACE_NAME == "br0" ) {
	SELF[escape('/etc/sysconfig/network-scripts/ifcfg-br0')] = 
	nlist(
		'config', format(file_contents('common/network/ipv6/ifcfg-br0'),
				_STRATUSLAB_IPV4_ADDRESS,
				_STRATUSLAB_IPV4_NETMASK,
				_STRATUSLAB_IPV6_ADDRESS,
				_STRATUSLAB_IPV6_GATEWAY
		),
		'backup',false,
	);
	SELF[escape('/etc/sysconfig/network-scripts/ifcfg-'+boot_nic())] = 
	nlist(
		'config', format( file_contents('common/network/ipv6/ifcfg-eth-br0'),
			boot_nic(),
			_STRATUSLAB_HW_ADDRESS,
		),
		'backup',false,
	);
	SELF;
} else {
	SELF[escape('/etc/sysconfig/network-scripts/ifcfg-'+_STRATUSLAB_INTERFACE_NAME)] = 
	nlist('config',
		format(
			file_contents('common/network/ipv6/ifcfg-eth'),
				_STRATUSLAB_INTERFACE_NAME,
				_STRATUSLAB_HW_ADDRESS,
				_STRATUSLAB_IPV4_ADDRESS,
				_STRATUSLAB_IPV4_NETMASK,
				_STRATUSLAB_IPV6_ADDRESS,
				_STRATUSLAB_IPV6_GATEWAY
		),
		'backup',false,
	);
	SELF;
};

'filecopy/services/{/etc/sysconfig/network}'=nlist(
	'config', format(file_contents('common/network/ipv6/network'),
		FULL_HOSTNAME,
		_STRATUSLAB_IPV4_GATEWAY
	),
);

'/software/components/sysctl/variables/net.ipv6.conf.all.forwarding' = '1';
include { 'config/stratuslab/named' };
