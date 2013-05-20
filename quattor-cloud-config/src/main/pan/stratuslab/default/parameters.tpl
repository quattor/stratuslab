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

unique template stratuslab/default/parameters;

include { if_exists('stratuslab/one/service/site_parameters') };

#
# OpenNebula user and group.
#
variable ONE_USER ?= 'oneadmin';
variable ONE_USER_ID ?= 9000;
variable ONE_GROUP ?= 'cloud';
variable ONE_GROUP_ID ?= 9000;

#
# OpenNebula files and directories.
#
variable ONE_SERVICE ?= 'oned';
variable ONE_HOOKS_DIR ?= '/usr/share/one/hooks/';

#
# Full hostname of NFS server, usually OpenNebula front-end.
#
variable ONE_NFS_SERVER ?= error('ONE_NFS_SERVER must be defined');

#
# An NFS wildcard that includes all of the OpenNebula nodes.
#
variable ONE_NFS_WILDCARD ?= error('ONE_NFS_WILDCARD must be defined');

#
# Monitoring internal in seconds.  Increase this value for
# a production system.
#
variable ONE_MONITOR_INTERVAL ?= 30;

#
# VM polling interval in seconds.  Increase this value for
# a production system.
#
variable ONE_POLLING_INTERVAL ?= 30;

#
# Ganglia variables
#
variable GANGLIA_MASTER ?= error('GANGLIA_MASTER must be defined');
variable GANGLIA_CLUSTER_NAME ?= 'StratusLab';

#
# Backend variables
#
variable ONE_SQL_BACKEND ?= 'SQLite';

#
# MySQL defaults.
#
variable MYSQL_USER ?= 'root';
variable MYSQL_PASSWORD ?= 'root';
variable MYSQL_HOST ?= 'localhost';
variable MYSQL_ONEDB ?= 'ONEDB';

#
# Quotas
#
variable ONE_CPU_QUOTA ?= 20.0;
variable ONE_RAM_KB_QUOTA ?= 41943040;

#
# IPV6 Activation
#
variable STRATUSLAB_IPV6_ENABLE ?= false;

#
# Global variable definition
#
variable STRATUSLAB_MAIL_EMAIL ?= 'no-reply@example.org';
variable STRATUSLAB_MAIL_HOST ?= 'smtp.example.org';
variable STRATUSLAB_MAIL_PORT ?= 465;
variable STRATUSLAB_MAIL_USER ?= 'no-reply@example.org';
variable STRATUSLAB_MAIL_USER_PWD ?= 'xxxxx';
variable STRATUSLAB_MAIL_SSL ?= true;
variable STRATUSLAB_MAIL_DEBUG ?= false;

variable STRATUSLAB_QUARANTINE_PERIOD ?= '15m';

variable STRATUSLAB_ROOT_PRIVATE_KEY ?= '/root/.ssh/id_dsa';

variable STRATUSLAB_HYPERVISOR_TYPE ?= error("Stratuslab hypervisor type must be defined");
