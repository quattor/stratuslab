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

include { if_exists('one/service/site_parameters') };

#
# OpenNebula user and group.
#
variable STRATUSLAB_UNIX_USER_ACCOUNT ?= 'oneadmin';
variable STRATUSLAB_UNIX_USER_ID      ?= 9000;
variable STRATUSLAB_UNIX_GROUP        ?= 'cloud';
variable STRATUSLAB_UNIX_GROUP_ID     ?= 9000;
variable STRATUSLAB_UNIX_USER_HOME    ?= '/home';

#
# OpenNebula var directory
#
variable STRATUSLAB_ONE_VARDIR ?= '/var/lib/one';

#
# MySQL defaults.
#
variable MYSQL_USER     ?= 'root';
variable MYSQL_PASSWORD ?= 'root';
variable MYSQL_HOST     ?= 'localhost';
variable MYSQL_ONEDB    ?= 'ONEDB';


#
# Global variable definition
#
variable STRATUSLAB_MAIL_EMAIL    ?= 'no-reply@example.org';
variable STRATUSLAB_MAIL_HOST     ?= 'smtp.example.org';
variable STRATUSLAB_MAIL_PORT     ?= 465;
variable STRATUSLAB_MAIL_USER     ?= 'no-reply@example.org';
variable STRATUSLAB_MAIL_USER_PWD ?= 'xxxxx';
variable STRATUSLAB_MAIL_SSL      ?= true;
variable STRATUSLAB_MAIL_DEBUG    ?= false;

variable STRATUSLAB_QUARANTINE_PERIOD ?= '15m';

variable STRATUSLAB_ROOT_PRIVATE_KEY ?= '/root/.ssh/id_dsa';

#
# Choose core OS templates
#
variable STRATUSLAB_CORE_OS_TEMPLATE ?= 'machine-types/core';

#
# If true configure NFS export / Import
# If false assume that share FS is configure by another templates (gpfs / ... )
# or NFS is not used
#
variable STRATUSLAB_NFS_ENABLE     ?= true;

#
# IPV6 Activation
#
variable STRATUSLAB_IPV6_ENABLE ?= false;

#
# Activate DHCP on frontend
#
variable STRATUSLAB_DHCPD_ENABLE ?= true;

#
# Ganglia configuration enabled
#
variable STRATUSLAB_GANGLIA_ENABLE ?= false;

#
# Define which version of spma
#
variable STRATUSLAB_SPMA_VERSION ?= 'spma2';

#
# Automatically enable OpenNebula VLAN depending on network
# configuration.
#
variable ONE_VLAN_ENABLE ?= {
    enable = false;
    foreach (network; params; ONE_NETWORK) {
        if (is_defined(params['vlan']))
            return(true);
    };
    return(false);
};

