# ${BUILD_INFO}
#
# Created as part of the StratusLab project (http://stratuslab.eu)
#
# Copyright (c) 2010, Centre Nationale de la Recherche Scientifique
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

'/software/packages' = pkg_repl('one','2.0-StratusLab.0.20101019.112628','x86_64');

# Include the benchmarks.
include { 'stratuslab-benchmarks' };

# StratusLab web monitor.
'/software/packages' = pkg_repl('stratuslab-web-monitor', '0.1-StratusLab.SNAPSHOT20100922152218', 'noarch');

# StratusLab client commands.
'/software/packages' = pkg_repl('stratuslab-cli-sysadmin', '1.0-SNAPSHOT20101019120952', 'noarch');
'/software/packages' = pkg_repl('stratuslab-cli-user', '1.0-SNAPSHOT20101019120850', 'noarch');

# MySQL client is compiled into oned (even if not used directly).
'/software/packages' = pkg_repl('mysql','5.0.77-4.el5_4.2','x86_64');

# Must have mkisofs for creating context images.
'/software/packages' = pkg_repl('mkisofs','2.01-10.7.el5','x86_64');

# Readonly module for components.
'/software/packages' = pkg_repl('perl-Readonly', '1.03-1.2.el5.rf', 'noarch');
