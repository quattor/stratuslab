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

unique template common/mysql/server;

# Include RPMs for MySQL server


# ----------------------------------------------------------------------------
# chkconfig
# ----------------------------------------------------------------------------
include { 'components/chkconfig/config' };


# ----------------------------------------------------------------------------
# Enable and start MySQL service
# ----------------------------------------------------------------------------
'/software/components/chkconfig/service/mysqld/on' = '';
'/software/components/chkconfig/service/mysqld/startstop' = true;


# ----------------------------------------------------------------------------
# accounts
# ----------------------------------------------------------------------------
# Should be done by the rpms.  If not, create the given template or add
# the information here.
#
#include { 'users/mysql' };


# ----------------------------------------------------------------------------
# iptables
# ----------------------------------------------------------------------------
#include { 'components/iptables/config' };

# Limit access to MySQL (port 3306) to the localhost.

include { 'components/iptables/config' };

'/software/components/iptables/filter/rules' = append(
  nlist('command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'source', '127.0.0.1',
        'dst_port', '3306',
        'target', 'accept'));

'/software/components/iptables/filter/rules' = append(
  nlist('command', '-A',
        'chain', 'INPUT',
        'protocol', 'tcp',
        'match', 'tcp',
        'dst_port', '3306',
        'target', 'reject',
        'reject-with', 'icmp-port-unreachable'));


# ----------------------------------------------------------------------------
# etcservices
# ----------------------------------------------------------------------------
include { 'components/etcservices/config' };

'/software/components/etcservices/entries' = append('mysql 3306/tcp');
'/software/components/etcservices/entries' = append('mysql 3306/udp');


# ----------------------------------------------------------------------------
# cron
# ----------------------------------------------------------------------------
#include { 'components/cron/config' };


# ----------------------------------------------------------------------------
# altlogrotate
# ----------------------------------------------------------------------------
#include { 'components/altlogrotate/config' };

prefix "/software/packages";

"{mysql-server}" = nlist();
