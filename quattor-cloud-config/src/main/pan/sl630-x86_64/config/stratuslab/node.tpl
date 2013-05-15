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

include {'config/stratuslab/base'};

# Readonly module for components.
'/software/packages'=pkg_repl('perl-Readonly','1.03-11.el6','noarch');

# XMLRPC
#'/software/packages' =pkg_repl('xmlrpc',        '2.0.1-6.6.fc13',       'x86_64');
'/software/packages' =pkg_repl('xmlrpc-c',       '1.16.24-1209.1840.el6','x86_64');
'/software/packages' =pkg_repl('xmlrpc-c-client','1.16.24-1209.1840.el6','x86_64');

# Need newer version of Ruby (fix for missing REXML::Formatter)
'/software/packages' =pkg_repl('ruby'      ,'1.8.7.352-7.el6_2','x86_64');
'/software/packages' =pkg_repl('ruby-irb'  ,'1.8.7.352-7.el6_2','x86_64');
'/software/packages' =pkg_repl('ruby-libs' ,'1.8.7.352-7.el6_2','x86_64');
'/software/packages' =pkg_repl('ruby-rdoc' ,'1.8.7.352-7.el6_2','x86_64');
'/software/packages' =pkg_repl('ruby-ri'   ,'1.8.7.352-7.el6_2','x86_64');
'/software/packages' =pkg_repl('ruby-tcltk','1.8.7.352-7.el6_2','x86_64');

'/software/packages' =pkg_repl('readline',        '6.0-4.el6',   'x86_64');
'/software/packages' =pkg_repl('compat-readline5','5.2-17.1.el6','x86_64');

# Java Dependencies
#'/software/packages' =pkg_repl('antlr3-C'                  ,'3.2-11.fc14'          ,'x86_64');
#'/software/packages' =pkg_repl('apache-commons-codec'      ,'1.4-10.fc14'          ,'noarch');
'/software/packages' =pkg_repl('jakarta-commons-httpclient','3.1-0.6.el6'           ,'x86_64');
'/software/packages' =pkg_repl('jakarta-commons-logging'   ,'1.0.4-10.el6'        ,'noarch');
'/software/packages' =pkg_repl('junit',                     '3.8.2-6.5.el6'       ,'x86_64');
'/software/packages' =pkg_repl('tomcat6-servlet-2.5-api',   '6.0.24-45.el6'      ,'noarch');

'/software/packages' =pkg_repl('python-ldap','2.3.10-1.el6','x86_64');

# Updated version of sqlite
'/software/packages' = pkg_repl('sqlite','3.6.20-1.el6','x86_64');

# Install squid
'/software/packages' = pkg_repl('squid','3.1.10-1.el6_2.4','x86_64');

include { 'config/os/updates' };
