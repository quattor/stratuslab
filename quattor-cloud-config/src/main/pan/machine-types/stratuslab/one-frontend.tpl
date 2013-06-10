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

unique template machine-types/stratuslab/one-frontend;

#
# Define if StratusLab front-end is a virtualization node too.
#
variable IS_VIRTUALIZATION_NODE ?= false;

#
# Configure PAT on StratusLab front-end
#
variable ENABLE_PAT ?= false;

include { 'machine-types/stratuslab/base' };

include { 'stratuslab/one/server/config' };
include { 'stratuslab/pdisk/host/config' };

#
# Include web server for OpenNebula web monitoring.
# Not yet included in standard installation.
#
include { 'rpms/web_server' };

#
# DHCP Configuration part
#

include {
  if ( STRATUSLAB_DHCPD_ENABLE ) {
    'stratuslab/one/service/dhcpd';
  } else {
    null;
  };
};

#
# IPv6 Configuration
#
include { if ( STRATUSLAB_IPV6_ENABLE ) {
    'stratuslab/one/service/dhcpd6';
  } else {
    null;
  }
};

include { if ( STRATUSLAB_IPV6_ENABLE ) {
    'common/network/ipv6/config';
  } else {
    null;
  };
};
