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
variable STRATUSLAB_OPENNEBULA_VERSION         ?= '3.2';

#
# OpenNebula and its dependencies.
#
'/software/packages' = {
    SELF[escape('one-'+STRATUSLAB_OPENNEBULA_VERSION+'-StratusLab')] = nlist();
    SELF[escape('quarantine-cleanup')] = nlist();
    SELF[escape('stratuslab-cli-sysadmin')] = nlist();
    SELF[escape('stratuslab-cli-user')] = nlist();
    SELF;
};

include { 'config/stratuslab/frontend' };
