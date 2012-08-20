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

unique template pdisk/rpms/daemon;

include { 'default/stratuslab/package-versions' };

variable STRATUSLAB_PDISK_VERSION ?= error('STRATUSLAB_PDISK_VERSION variable undefined');
'/software/packages'=pkg_repl('stratuslab-pdisk-server', STRATUSLAB_PDISK_VERSION, 'noarch');
variable STRATUSLAB_AUTHN_CONFIG_VERSION ?= error('STRATUSLAB_AUTHN_CONFIG_VERSION variable undefined');
'/software/packages'=pkg_repl('stratuslab-authn-config', STRATUSLAB_AUTHN_CONFIG_VERSION ,'noarch');
variable STRATUSLAB_PDISK_HOST_VERSION ?= STRATUSLAB_PDISK_VERSION;
'/software/packages'=pkg_repl('stratuslab-pdisk-host', STRATUSLAB_PDISK_HOST_VERSION, 'noarch');
'/software/packages'=pkg_repl('stratuslab-cli-user', STRATUSLAB_USER_CLI_VERSION, 'noarch');
