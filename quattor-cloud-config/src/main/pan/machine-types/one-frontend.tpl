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

unique template machine-types/one-frontend;

variable NEW_NETWORK_CONF ?= true;

variable FILESYSTEM_LAYOUT_CONFIG_SITE ?= "site/filesystems/glite";

include { 'machine-types/nfs' };

#
# Include web server for OpenNebula web monitoring.
# Not yet included in standard installation.
#
include { 'rpms/web_server' };

#
# Define the parameters for the OpenNebula setup.
# **CHANGE** the values in this file for your setup.
#
include { 'one/service/parameters' };

#
# Setup oneadmin account, libvirtd, and networking
#
include { 'one/service/common-config' };

#
# Ganglia for the monitoring of machines and hosts
#
include { 'ganglia/config' };

#
# Define the three areas to be exported to all nodes.
#
include { 'one/service/nfs-exports' };

#
# Setup the ssh keys and configuration for oneadmin account.
#
include { 'one/service/oneadmin-ssh-setup' };

# 
# Setup the OpenNebula daemon itself.
#
include { 'one/service/daemon' };

# 
# Include the packages (RPMs) for this node.
#
include { 'one/rpms/frontend' };
include { 'one/rpms/node' };
include { 'one/rpms/devel' };

# Add git to the machine, but git-svn is not needed.
include { 'config/os/git' };
'/software/packages' = pkg_del('git-svn');

# Authentication proxy
include { 'one/service/authn-proxy' };

# Add private interface
include { 'one/service/private-network' };

# Add firewall.
include { 'one/service/iptables-bridging' };
include { 'one/service/iptables-frontend' };

include { 'config/os/updates' };

