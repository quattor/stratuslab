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

include { 'stratuslab-package-versions' };

#
# OpenNebula and its dependencies. 
#
'/software/packages' = pkg_repl('one-2.2-StratusLab', STRATUSLAB_ONE_VERSION, 'x86_64');

'/software/packages' = pkg_repl('quarantine-cleanup', STRATUSLAB_QUARANTINE_CLEANUP_VERSION, 'noarch');

'/software/packages' = pkg_repl('rubygems','1.3.1-1.el5','noarch');
'/software/packages' = pkg_repl('rubygem-sequel','3.20.0-1','noarch');
'/software/packages' = pkg_repl('rubygem-sqlite3-ruby','1.2.4-1.el5','x86_64');

# Include the benchmarks.
include { 'stratuslab-benchmarks' };

# StratusLab web monitor.
'/software/packages' = pkg_repl('stratuslab-web-monitor', STRATUSLAB_WEB_MONITOR_VERSION, 'noarch');

# StratusLab client commands.
'/software/packages' = pkg_repl('stratuslab-cli-sysadmin', STRATUSLAB_SYSADMIN_CLI_VERSION, 'noarch');
'/software/packages' = pkg_repl('stratuslab-cli-user', STRATUSLAB_USER_CLI_VERSION, 'noarch');

# MySQL client is compiled into oned (even if not used directly).
'/software/packages' = pkg_repl('mysql','5.0.77-4.el5_4.2','x86_64');

# Must have mkisofs for creating context images.
'/software/packages' = pkg_repl('mkisofs','2.01-10.7.el5','x86_64');

# Readonly module for components.
'/software/packages' = pkg_repl('perl-Readonly', '1.03-1.2.el5.rf', 'noarch');

