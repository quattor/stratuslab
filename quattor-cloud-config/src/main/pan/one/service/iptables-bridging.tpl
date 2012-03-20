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

unique template one/service/iptables-bridging;

variable STRATUSLAB_IPTABLES_ENABLE ?= false;

include { 'common/iptables/base' };

#
# INPUT chain for the virbr0 interface (private NAT'ed ports).
#
'/software/components/iptables/filter/rules' = {
  append(nlist('command', '-A',
               'chain', 'INPUT',
               'in_interface', 'virbr0',
               'protocol', 'udp',
               'match', 'udp',
               'dst_port', '53',
               'target', 'accept'));
  append(nlist('command', '-A',
               'chain', 'INPUT',
               'in_interface', 'virbr0',
               'protocol', 'tcp',
               'match', 'tcp',
               'dst_port', '53',
               'target', 'accept'));
  append(nlist('command', '-A',
               'chain', 'INPUT',
               'in_interface', 'virbr0',
               'protocol', 'udp',
               'match', 'udp',
               'dst_port', '67',
               'target', 'accept'));
  append(nlist('command', '-A',
               'chain', 'INPUT',
               'in_interface', 'virbr0',
               'protocol', 'tcp',
               'match', 'tcp',
               'dst_port', '67',
               'target', 'accept'));
};

#
# FORWARD chain for the virbr0 interface (private NAT'ed ports).
#
'/software/components/iptables/filter/rules' = {
  append(nlist('command', '-A',
               'chain', 'FORWARD',
               'out_interface', 'virbr0',
               'destination', '192.168.122.0/24',
               'match', 'state',
               'state', 'RELATED,ESTABLISHED',
               'target', 'accept'));
  append(nlist('command', '-A',
               'chain', 'FORWARD',
               'in_interface', 'virbr0',
               'source', '192.168.122.0/24',
               'target', 'accept'));
  append(nlist('command', '-A',
               'chain', 'FORWARD',
               'in_interface', 'virbr0',
               'out_interface', 'virbr0',
               'target', 'accept'));
  append(nlist('command', '-A',
               'chain', 'FORWARD',
               'out_interface', 'virbr0',
               'target', 'reject',
               'reject-with', 'icmp-port-unreachable'));
  append(nlist('command', '-A',
               'chain', 'FORWARD',
               'in_interface', 'virbr0',
               'target', 'reject',
               'reject-with', 'icmp-port-unreachable'));
};

'/software/components/iptables/nat/preamble/prerouting' = 'ACCEPT [0:0]';
'/software/components/iptables/nat/preamble/postrouting' = 'ACCEPT [0:0]';
'/software/components/iptables/nat/preamble/output' = 'ACCEPT [0:0]';
'/software/components/iptables/nat/epilogue' = 'COMMIT';

#
# FORWARD chain for the virbr0 interface (private NAT'ed ports).
#
'/software/components/iptables/nat/rules' = {
  append(nlist('command', '-A',
               'chain', 'POSTROUTING',
               'source', '192.168.122.0/24',
               'destination', '! 192.168.122.0/24',
               'protocol', 'tcp',
               'to-ports', '1024-65535',
               'target', 'MASQUERADE'));
  append(nlist('command', '-A',
               'chain', 'POSTROUTING',
               'source', '192.168.122.0/24',
               'destination', '! 192.168.122.0/24',
               'protocol', 'udp',
               'to-ports', '1024-65535',
               'target', 'MASQUERADE'));
  append(nlist('command', '-A',
               'chain', 'POSTROUTING',
               'source', '192.168.122.0/24',
               'destination', '! 192.168.122.0/24',
               'target', 'MASQUERADE'));
};
