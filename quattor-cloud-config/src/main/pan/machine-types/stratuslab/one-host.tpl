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
# Define the parameters for the OpenNebula setup.
# **CHANGE** the values in this file for your setup.
#
include { 'stratuslab/default/parameters' };

#
# Setup oneadmin account, libvirtd, and networking
#
include { 'one/service/common-config' };
include { 'one/service/node-config' };

#
# DEBUG DEBUG DEBUG DEBUG DEBUG
#
include { 'pdisk/host/config' };

#
# Ganglia for the monitoring of machines and hosts
#
include { 'ganglia/config' };

#
# Import the common areas from the OpenNebula server.
#
variable NFS_IMPORTS ?= true;
include {
  if( NFS_IMPORTS ) {
    'common/nfs/nfs-imports';
  } else {
    null;
  };
};

#
# Include the packages (RPMs) for the node.
#
include { 'one/rpms/node' };
include { 'one/rpms/devel' };

#
# Include the packages (RPMs) for iscsi-initiator.
#
#include { 'iscsi/rpms/initiator' };

include { if (STRATUSLAB_IPV6_ENABLE) {
		'common/network/ipv6/config';
	} else {
		null;
	}
};

"/software/packages/{libvirt-client}" = nlist();
"/software/packages/{libvirt}" = nlist();
"/software/packages/{libvirt-python}" = nlist();
