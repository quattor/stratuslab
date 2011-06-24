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

unique template claudia/service/daemon;

include { 'claudia/rpms/daemon' };

include { 'components/claudia/config' };

variable IP_CLAUDIA_PUBLIC_RANGE = {
ip_claudia = '';
foreach(k;v;ONE_NETWORK['public']['vms']) {
        if (v['claudia'] != 'no') {
         ip_claudia = ip_claudia+v['fixed-address']+"/";
        };
};
ip_claudia;
};

variable MAC_CLAUDIA_PUBLIC_RANGE = {
ip_claudia = '';
foreach(k;v;ONE_NETWORK['public']['vms']) {
        if (v['claudia'] != 'no') {
         ip_claudia = ip_claudia+v['mac-address']+"/";
        };
};
ip_claudia;
};


variable STATIC_CLAUDIA = {
 ip_claudia = '';
foreach(k;v;ONE_NETWORK['public']['vms']) {
        if (v['claudia'] == 'sta') {
         ip_claudia = ip_claudia+v['fixed-address']+"/";
        };
};
 ip_claudia;
};

variable IP_CLAUDIA_LOCAL_RANGE = {
ip_claudia = '';
foreach(k;v;ONE_NETWORK['local']['vms']) {
        if (v['claudia'] != 'no') {
         ip_claudia = ip_claudia+v['fixed-address']+"/";
        };
};
ip_claudia;
};

prefix '/software/components/claudia';
'sm-config/NetworkRanges/0' = nlist(
                            'Network', ONE_NETWORK['public']['subnet'],
                            'Netmask', ONE_NETWORK['public']['netmask'],
                            'Gateway', ONE_NETWORK['public']['router'],
                            'DNS',     ONE_NETWORK['nameserver'][0],
                            'IP',      IP_CLAUDIA_PUBLIC_RANGE,
                            'Public', true
                        );

'sm-config/NetworkRanges/1' = nlist(
                         'Network', ONE_NETWORK['local']['subnet'],
                         'Netmask', ONE_NETWORK['local']['netmask'],
                         'Gateway', ONE_NETWORK['local']['router'],
                         'DNS',     ONE_NETWORK['nameserver'][0],
                         'IP',      IP_CLAUDIA_LOCAL_RANGE,
                         'Public',  false
                        );

'sm-config/StaticIpList'   = STATIC_CLAUDIA;
'sm-config/NetworkMac/NetworkMacList' = MAC_CLAUDIA_PUBLIC_RANGE;

'sm-config/SiteRoot'      = ONE_NETWORK['domain'];
'sm-config/WASUP/WASUPLogin'   = 'oneadmin';
'sm-config/WASUP/WASUPPassword' = 'secret';

'reportClient-config/SiteRoot' = ONE_NETWORK['domain'];

'tcloud-config/onePassword' = '42d9d2622f862cd803d4395be2c1edd362213525';
'tcloud-config/oneSshKey'   = 'ssh-rsa ';

include { 'components/accounts/config' };
# Create the 'oneadmin' user and 'cloud' group for OpenNebula.
'/software/components/accounts/groups/activemq/gid' = 9001;
'/software/components/accounts/users/activemq' = nlist(
  'uid', 9001,
  'groups', list('activemq'),
  'homeDir', '/home/activemq',
#  'createHome', false,
#  'createKeys', false
);

include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/tcloudd/on'  = '';
'/software/components/chkconfig/service/clothod/on'  = '';
'/software/components/chkconfig/service/activemq/on' = '';

#
# Fix activemq issue with permission directory
#
# We must find another way to fix it with quattor
#

include { 'components/filecopy/config' };

variable CONTENTS = <<EOF;
RUN_AS_USER=root
EOF
"/software/components/filecopy/services" =
  npush(escape("/etc/sysconfig/activemq"),
        nlist("config",CONTENTS,
              "restart","service activemq restart",
              "perms","0644"));


