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

unique template one/rpms/frontend;

include { 'default/stratuslab/package-versions' };

variable STRATUSLAB_ONE_VERSION                ?= error('STRATUSLAB_ONE_VERSION variable undefined');
variable STRATUSLAB_OPENNEBULA_VERSION         ?= '3.0';
variable STRATUSLAB_QUARANTINE_CLEANUP_VERSION ?= error('STRATUSLAB_QUARANTINE_CLEANUP_VERSION variable undefined');
variable STRATUSLAB_WEB_MONITOR_VERSION        ?= error('STRATUSLAB_WEB_MONITOR_VERSION variable undefined');
variable STRATUSLAB_SYSADMIN_CLI_VERSION       ?= error('STRATUSLAB_SYSADMIN_CLI_VERSION variable undefined');
variable STRATUSLAB_USER_CLI_VERSION           ?= error('STRATUSLAB_USER_CLI_VERSION variable undefined');

#
# OpenNebula and its dependencies. 
#
'/software/packages' = pkg_repl('one-'+STRATUSLAB_OPENNEBULA_VERSION+'-StratusLab', STRATUSLAB_ONE_VERSION, 'x86_64');

'/software/packages' = pkg_repl('quarantine-cleanup', STRATUSLAB_QUARANTINE_CLEANUP_VERSION, 'noarch');

'/software/packages' = pkg_repl('rubygem-bunny','0.6.0-1.fc14','noarch');
'/software/packages' = pkg_repl('rubygem-stomp','1.1.6-1.fc14','noarch');
'/software/packages' = pkg_repl('qemu-img','0.13.0-0.7.rc1.fc14','x86_64');
'/software/packages' = pkg_repl('ruby-sqlite3','1.2.4-5.fc12','x86_64');
'/software/packages' = pkg_repl('rubygem-json','1.4.3-2.fc14','x86_64');

# Not included in rhel5 and fedora14
'/software/packages' = pkg_repl('rubygem-sequel','3.20.0-1','noarch');

# Include the benchmarks.
include { 'machine-types/stratuslab-benchmarks' };

# StratusLab web monitor.
'/software/packages' = pkg_repl('stratuslab-web-monitor', STRATUSLAB_WEB_MONITOR_VERSION, 'noarch');

# StratusLab client commands.
'/software/packages' = pkg_repl('stratuslab-cli-sysadmin', STRATUSLAB_SYSADMIN_CLI_VERSION, 'noarch');
'/software/packages' = pkg_repl('stratuslab-cli-user', STRATUSLAB_USER_CLI_VERSION, 'noarch');

include { 'config/stratuslab/frontend' };
