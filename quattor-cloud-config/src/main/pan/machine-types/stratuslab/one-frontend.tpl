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

variable FILESYSTEM_LAYOUT_CONFIG_SITE ?= "site/filesystems/glite";

include { 'machine-types/stratuslab/base' };

#
# Include web server for OpenNebula web monitoring.
# Not yet included in standard installation.
#
include { 'rpms/web_server' };

#
# Define the parameters for the OpenNebula setup.
# **CHANGE** the values in this file for your setup.
#
include { 'stratuslab/default/parameters' };

#
# Setup common and specific configurations.
#
include { 'one/service/common-config' };
include {
  if( IS_VIRTUALIZATION_NODE ) {
    'one/service/node-config';
  } else {
    null;
  };
};

#
# Ganglia for the monitoring of machines and hosts
#
include { 'ganglia/config' };

#
# Define the three areas to be exported to all nodes.
#
include { 'common/nfs/nfs-exports' };
include { 'common/nfs/nfs-imports' };

#
# Setup the ssh keys and configuration for oneadmin account.
#
include { 'one/service/oneadmin-ssh-setup' };

#
# Setup the OpenNebula daemon itself.
#
include { 'one/service/daemon' };

#
# Setup the OpenNebula networking.
#
include { 'one/service/onevnet-config' };

#
# Setup the OpenNebula hypervisor
#
include { 'one/server/node-config' };

#
# Setup mysql if we want use mysql backend
#
include {
	if ( ONE_SQL_BACKEND == 'mysql' ) {
		'one/service/mysql';
	};
};

#
# Setup claudia
#
include { 'claudia/service/daemon' };

#
# Include the packages (RPMs) for this node.
#
include { 'one/rpms/frontend' };
include {
  if(IS_VIRTUALIZATION_NODE) {
    'one/rpms/node';
  } else {
    null;
  };
};
include { 'one/rpms/devel' };

#
# Include the packages (RPMs) for iscsi-target.
#
include { 'iscsi/rpms/target' };

# Add git to the machine, but git-svn is not needed.
include { 'config/os/git' };
'/software/packages' = pkg_del('git-svn');

# Authentication proxy
include { 'stratuslab/one-proxy/config' };

# Add private interface
include { 'one/service/private-network' };

# Configure port address translations
include {
  if(ENABLE_PAT) {
    'one/service/pat';
  } else {
    null;
  };
};

# Add firewall.
include {
  if(IS_VIRTUALIZATION_NODE) {
    'one/service/iptables-bridging';
  } else {
    null;
  };
};
include { 'one/service/iptables-frontend' };

include { 'one/service/tm_stratuslab' };

include { 'config/os/updates' };

# Add support for pxe
#include { 'one/service/pxe' };

# Add configuration for tftp server
#include { 'one/service/tftp' };

#
# DHCP Configuration part
#

include { 'one/service/dhcpd' };


