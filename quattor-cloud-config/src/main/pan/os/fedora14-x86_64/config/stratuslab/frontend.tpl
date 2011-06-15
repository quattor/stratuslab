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

unique template config/stratuslab/frontend;

'/software/packages'=pkg_repl('xmlrpc-c-c++','1.23.03-1400.svn1979.fc14','x86_64');
'/software/packages'=pkg_repl('xmlrpc-c-client++','1.23.03-1400.svn1979.fc14','x86_64');

'/software/packages'=pkg_repl('rubygems','1.3.7-2.fc14','noarch');
'/software/packages'=pkg_repl('rubygem-sqlite3-ruby','1.2.4-5.fc12','x86_64');
'/software/packages'=pkg_repl('ruby-mysql','2.8.2-1.fc14','x86_64');

# MySQL client is compiled into oned (even if not used directly).
'/software/packages'=pkg_repl('mysql','5.1.51-2.fc14','x86_64');

# Must have mkisofs for creating context images.
'/software/packages' = pkg_repl('genisoimage','1.1.10-2.fc14','x86_64');

# Readonly module for components.
'/software/packages' = pkg_repl('perl-Readonly','1.03-13.fc14','noarch');

include { 'config/os/updates' };
