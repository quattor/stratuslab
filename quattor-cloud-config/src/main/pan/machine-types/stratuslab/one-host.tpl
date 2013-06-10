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

unique template machine-types/stratuslab/one-host;

include { 'machine-types/stratuslab/base' };

#
# Configure OpenNebula hypervisor
#
include { 'stratuslab/one/host/config' };

# Configure pdisk client
#
include { 'stratuslab/pdisk/host/config' };

#
# Configure IPv6 if enable
#
include { if (STRATUSLAB_IPV6_ENABLE) {
    'common/network/ipv6/config';
  } else {
    null;
  }
};
