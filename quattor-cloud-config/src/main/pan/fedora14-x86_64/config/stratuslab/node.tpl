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

unique template config/stratuslab/node;

# Readonly module for components.
'/software/packages'=pkg_repl('perl-Readonly','1.03-13.fc14','noarch');

# XMLRPC
'/software/packages' =pkg_repl('xmlrpc'  ,'2.0.1-6.6.fc13'           ,'x86_64');
'/software/packages' =pkg_repl('xmlrpc-c','1.23.03-1400.svn1979.fc14','x86_64');
'/software/packages' =pkg_repl('xmlrpc-c-client','1.23.03-1400.svn1979.fc14','x86_64');

# Need newer version of Ruby (fix for missing REXML::Formatter)
'/software/packages' =pkg_repl('ruby'      ,'1.8.7.302-1.fc14','x86_64');
'/software/packages' =pkg_repl('ruby-irb'  ,'1.8.7.302-1.fc14','noarch');
'/software/packages' =pkg_repl('ruby-libs' ,'1.8.7.302-1.fc14','x86_64');
'/software/packages' =pkg_repl('ruby-rdoc' ,'1.8.7.302-1.fc14','noarch');
'/software/packages' =pkg_repl('ruby-ri'   ,'1.8.7.302-1.fc14','x86_64');
'/software/packages' =pkg_repl('ruby-tcltk','1.8.7.302-1.fc14','x86_64');

'/software/packages' =pkg_repl('readline','6.1-2.fc14','x86_64');
'/software/packages'=pkg_repl('compat-readline5','5.2-17.fc12','x86_64');

# Java Dependencies
'/software/packages' =pkg_repl('antlr3-C'                  ,'3.2-11.fc14'          ,'x86_64');
'/software/packages' =pkg_repl('apache-commons-codec'      ,'1.4-10.fc14'          ,'noarch');
'/software/packages' =pkg_repl('jakarta-commons-httpclient','3.1-1.fc14'           ,'noarch');
'/software/packages' =pkg_repl('apache-commons-logging'    ,'1.1.1-11.fc14'        ,'noarch');
'/software/packages' =pkg_repl('junit'                     ,'3.8.2-6.4.fc12'       ,'x86_64');
'/software/packages' =pkg_repl('tomcat5-servlet-2.4-api'   ,'5.5.27-7.4.fc12'      ,'noarch');

'/software/packages' =pkg_repl('python-ldap','2.3.10-2.fc14','x86_64');
# Updated version of sqlite
'/software/packages' = pkg_repl('sqlite','3.6.23.1-1.fc14','x86_64');

# Install squid
'/software/packages' = pkg_repl('squid','3.1.8-1.fc14','x86_64');

include { 'config/os/updates' };
