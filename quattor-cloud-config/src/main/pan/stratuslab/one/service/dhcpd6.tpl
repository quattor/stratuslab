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

unique template stratuslab/one/service/dhcpd6;

include { 'stratuslab/one/rpms/'+STRATUSLAB_SPMA_VERSION+'/dhcpd' };

function ipv4tov6 = {
	ipv4=ARGV[0];
	ids = replace('\.',':',ipv4);
	ipv6_prefix = split('/',STRATUSLAB_ONE_IPV6_PREFIX);
	ipv6 = replace('::','',ipv6_prefix[0])+":"+ids;
	ipv6;
};

include { 'components/filecopy/config' };

variable ONE_DHCP_DOMAIN = ONE_NETWORK['domain'];
variable ONE_DHCP_NAMESERVER = ONE_NETWORK['nameserver'];
variable ONE_DHCPD_PUBLIC_COMMON  = nlist('subnet' ,ONE_NETWORK['public']['subnet'],
                                          'router' ,ONE_NETWORK['public']['router'],
                                          'netmask',ONE_NETWORK['public']['netmask'],
                                    );
variable ONE_DHCPD_LOCAL_COMMON = nlist('subnet' ,ONE_NETWORK['local']['subnet'],
                                        'router' ,ONE_NETWORK['local']['router'],
                                        'netmask',ONE_NETWORK['local']['netmask'],
                                    );

variable ONE_DHCP_PUBLIC = {
        net = nlist();
        foreach(k;v;ONE_NETWORK['public']['vms']) {
                net[k]=v;
        };
        net;
};

variable ONE_DHCP_LOCAL = {
        net = nlist();
        foreach(k;v;ONE_NETWORK['local']['vms']) {
                net[k]=v;
        };
        net;
};

#
# ONE_DHCP_PUBLIC and ONE_DHCP_LOCAL must be like nlist('machine-name',nlist('mac-address','value-of-mac-address','fixed-address','value-of-fixed-address'))
#

variable ONE_DHCP_PUBLIC ?= nlist();
variable ONE_DHCP_LOCAL ?= nlist();

variable DHCPD_CONF = <<EOF;
EOF

variable DHCPD_CONF = DHCPD_CONF + 'option dhcp6.domain-search "'+ONE_DHCP_DOMAIN+"\";\n";

variable ONE_DHCP_NAMESERVER_STRING = {
	contents = '';
	foreach (k;v;ONE_DHCP_NAMESERVER) {
		if ( contents == '') {
			contents = v;
		} else {
			contents = contents + ',' + v;
		}
	};
	contents;
};

variable DHCPD_CONF = DHCPD_CONF + <<EOF;
#----------------------------------------------------------
group {
EOF

variable PUBLIC_CONF_STRING = {
	contents = '';
	foreach (k;v;ONE_DHCP_PUBLIC) {
		contents = contents + 'host '+k+" {\n";
		contents = contents + '    hardware ethernet '+v['mac-address']+";\n";
		contents = contents + '    fixed-address6 '+ipv4tov6(v['fixed-address'])+";\n";
		contents = contents + "}\n";
	};
	contents;
};

variable DHCPD_CONF = DHCPD_CONF + PUBLIC_CONF_STRING;
variable DHCPD_CONF = DHCPD_CONF + <<EOF;
}
EOF

variable DHCPD_CONF = DHCPD_CONF + <<EOF;
#----------------------------------------------------------
shared-network StratusLab-LAN {
EOF

variable SHARED_NETWORK_STRING = {
	contents = '';
	contents = contents + 'subnet6 '+STRATUSLAB_ONE_IPV6_PREFIX+" {\n";
	contents = contents + "}\n";
	contents;
};

variable DHCPD_CONF = DHCPD_CONF + SHARED_NETWORK_STRING;
variable DHCPD_CONF = DHCPD_CONF + <<EOF;
}
EOF

"/software/components/filecopy/services" = npush(
        escape("/etc/dhcp/dhcpd6.conf"),
        nlist("config",DHCPD_CONF,
              "owner","root",
              "group","root",
              "perms","0644",
              "restart","/usr/bin/killall -HUP dhcpd")
    );


include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/dhcpd6/on" = "";
"/software/components/chkconfig/service/dhcpd6/startstop" = true;
