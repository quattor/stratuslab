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

unique template one/service/private-network;

variable PRIVATE_NET        ?= '172.17.16.0/24';
variable PRIVATE_IP         ?= '172.17.16.1';
variable PRIVATE_NETMASK    ?= '255.255.255.0';
variable PRIVATE_MASTER_INT ?= STRATUSLAB_BR_INTERFACE;
variable PRIVATE_INT_NAME   ?= 'privlan';

include { 'components/network/config' };

'/system/network/interfaces/' = {
    SELF[PRIVATE_MASTER_INT]['aliases'] = nlist(
        PRIVATE_INT_NAME, nlist(
            'ip', PRIVATE_IP,
            'netmask', PRIVATE_NETMASK,
        ),
    );
    SELF;
};

include { 'components/iptables/config' };

'/software/components/iptables/nat/epilogue' = 'COMMIT';
'/software/components/iptables/filter/epilogue' = 'COMMIT';

# NAT private LAN interface
'/software/components/iptables/nat/rules' = append(
  nlist('command', '-A',
        'chain', 'POSTROUTING',
        'source', PRIVATE_NET,
        'destination', '! '+PRIVATE_NET,
        'target', 'MASQUERADE')
);

'/software/components/iptables/filter/rules' = {
  append(nlist('command', '-A',
               'chain', 'FORWARD',
               'destination', PRIVATE_NET,
               'match', 'state',
               'state', 'RELATED,ESTABLISHED',
               'target', 'accept'));
  append(nlist('command', '-A',
               'chain', 'FORWARD',
               'source', PRIVATE_NET,
               'target', 'accept'));
};

# Enable IP forwarding
include { 'components/sysctl/config' };
'/software/components/sysctl/variables/net.ipv4.ip_forward' = '1';
