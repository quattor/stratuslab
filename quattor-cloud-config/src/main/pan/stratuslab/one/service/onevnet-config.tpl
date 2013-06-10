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

unique template stratuslab/one/service/onevnet-config;

include { 'components/oned/config' };

variable STRATUSLAB_PRIVATE_NETWORK_CONFIG = <<EOF;
NAME=private
PUBLIC=YES
TYPE=RANGED
BRIDGE=virbr0
NETWORK_ADDRESS=192.168.122.0
NETWORK_SIZE=252
EOF

variable STRATUSLAB_LOCAL_NETWORK_HEADER = <<EOF;
NAME=local
PUBLIC=YES
TYPE=FIXED
EOF

variable STRATUSLAB_LOCAL_NETWORK_BRIDGE = 'BRIDGE='+ONE_NETWORK['local']['interface']+"\n\n";

variable STRATUSLAB_PUBLIC_NETWORK_HEADER = <<EOF;
NAME=public
PUBLIC=YES
TYPE=FIXED
EOF

variable STRATUSLAB_PUBLIC_NETWORK_BRIDGE = 'BRIDGE='+ONE_NETWORK['public']['interface']+"\n\n";

variable STRATUSLAB_LOCAL_NETWORK_BODY = {
        result = '';
        foreach (k;v;ONE_NETWORK['local']['vms']){
                if (v['claudia'] == 'no') {
                        result = result+'LEASES=[ IP='+v['fixed-address']+', MAC='+v['mac-address']+" ]\n";
                };
        };
        result;
};

variable STRATUSLAB_LOCAL_NETWORK_CONFIG = STRATUSLAB_LOCAL_NETWORK_HEADER + STRATUSLAB_LOCAL_NETWORK_BRIDGE + STRATUSLAB_LOCAL_NETWORK_BODY;

variable STRATUSLAB_PUBLIC_NETWORK_HEADER = <<EOF;
NAME=public
PUBLIC=YES
TYPE=FIXED
EOF

variable STRATUSLAB_PUBLIC_NETWORK_BODY = {
        result = '';
        foreach (k;v;ONE_NETWORK['public']['vms']){
                if (v['claudia'] == 'no') {
                        result = result+'LEASES=[ IP='+v['fixed-address']+', MAC='+v['mac-address']+" ]\n";
                };
        };
        result;
};

variable STRATUSLAB_PUBLIC_NETWORK_CONFIG = STRATUSLAB_PUBLIC_NETWORK_HEADER + STRATUSLAB_PUBLIC_NETWORK_BRIDGE + STRATUSLAB_PUBLIC_NETWORK_BODY;


prefix '/software/components/oned/vnets';

'private' = STRATUSLAB_PRIVATE_NETWORK_CONFIG;
'local' = STRATUSLAB_LOCAL_NETWORK_CONFIG;
'public' = STRATUSLAB_PUBLIC_NETWORK_CONFIG;
