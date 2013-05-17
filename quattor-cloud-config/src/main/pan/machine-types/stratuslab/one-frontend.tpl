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
# Define the parameters for the OpenNebula setup.
# **CHANGE** the values in this file for your setup.
#
include { 'stratuslab/default/parameters' };

#
# Setup common and specific configurations.
#
include { 'stratuslab/one/service/common-config' };
include {
  if( IS_VIRTUALIZATION_NODE ) {
    'stratuslab/one/service/node-config';
  } else {
    null;
  };
};

#
# Ganglia for the monitoring of machines and hosts
#
include { 'common/ganglia/config' };

#
# Define the three areas to be exported to all nodes.
#
variable NFS_EXPORTS ?= true;
include {
  if( NFS_EXPORTS ) {
    'common/nfs/nfs-exports';
  } else {
    null;
  };
};
variable NFS_IMPORTS ?= true;
include {
  if( NFS_IMPORTS ) {
    'common/nfs/nfs-imports';
  } else {
    null;
  };
};

include 'stratuslab/one/rpms/frontend';
#
# Setup the ssh keys and configuration for oneadmin account.
#
include { 'stratuslab/one/service/oneadmin-ssh-setup' };

#
# Setup the OpenNebula daemon itself.
#
include { 'stratuslab/one/service/daemon' };

#
# Setup the OpenNebula networking.
#
include { 'stratuslab/one/service/onevnet-config' };

#
# Setup the OpenNebula hypervisor
#
include { 'stratuslab/one/server/node-config' };

#
# Setup mysql if we want use mysql backend
#
include {
	if ( ONE_SQL_BACKEND == 'mysql' ) {
		'stratuslab/one/service/mysql';
	};
};

#
# Setup claudia
#
#include { 'claudia/service/daemon' };

#
# Include the packages (RPMs) for this node.
#
include {
  if(IS_VIRTUALIZATION_NODE) {
    'stratuslab/one/rpms/node';
  } else {
    null;
  };
};
#
# Include the packages (RPMs) for iscsi-target.
#
# Authentication proxy
include { 'stratuslab/one-proxy/config' };

# Add private interface
include { 'stratuslab/one/service/private-network' };

# Configure port address translations
include {
  if(ENABLE_PAT) {
    'stratuslab/one/service/pat';
  } else {
    null;
  };
};

# Add firewall.
include {
  if(IS_VIRTUALIZATION_NODE) {
    'stratuslab/one/service/iptables-bridging';
  } else {
    null;
  };
};
include { 'stratuslab/one/service/iptables-frontend' };

include { 'stratuslab/one/service/tm_stratuslab' };


# Add support for pxe
#include { 'stratuslab/one/service/pxe' };

# Add configuration for tftp server
#include { 'stratuslab/one/service/tftp' };

#
# DHCP Configuration part
#

include { 'stratuslab/one/service/dhcpd' };
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
