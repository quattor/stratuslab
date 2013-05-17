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

prefix "/software/packages";

# Readonly module for components.
'{perl-Readonly}' = nlist();

# XMLRPC
#'/software/packages' =pkg_repl('xmlrpc',        '2.0.1-6.6.fc13',       'x86_64');
'{xmlrpc-c}' = nlist();
'{xmlrpc-c-client}' = nlist();

# Need newer version of Ruby (fix for missing REXML::Formatter)
'{ruby}' = nlist();
'{ruby-irb}' = nlist();
'{ruby-libs}' = nlist();
'{ruby-rdoc}' = nlist();
'{ruby-ri}' = nlist();
'{ruby-tcltk}' = nlist();

'{readline}' = nlist();
'{compat-readline5}' = nlist();

# Java Dependencies
#'/software/packages' =pkg_repl('antlr3-C'                  ,'3.2-11.fc14'          ,'x86_64');
#'/software/packages' =pkg_repl('apache-commons-codec'      ,'1.4-10.fc14'          ,'noarch');
'{jakarta-commons-httpclient}' = nlist();
'{jakarta-commons-logging}' = nlist();
'{junit}' = nlist();
'{tomcat6-servlet-2.5-api}' = nlist();

'{python-ldap}' = nlist();

# Updated version of sqlite
'{sqlite}' = nlist();

# Install squid
'{squid}' = nlist();

include 'config/stratuslab/hypervisors/' + STRATUSLAB_HYPERVISOR_TYPE;
