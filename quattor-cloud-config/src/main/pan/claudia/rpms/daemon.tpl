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

unique template claudia/rpms/daemon;

include { 'default/stratuslab/package-versions' };

variable STRATUSLAB_CLAUDIA_CLIENT_VERSION ?= error('STRATUSLAB_CLAUDIA_CLIENT_VERSION variable undefined');
'/software/packages'=pkg_repl('claudia-client-rpm',STRATUSLAB_CLAUDIA_CLIENT_VERSION,'noarch');
'/software/packages'=pkg_repl('clotho-rpm'        ,STRATUSLAB_CLAUDIA_CLIENT_VERSION,'noarch');
'/software/packages'=pkg_repl('tcloud-server-rpm' ,STRATUSLAB_CLAUDIA_CLIENT_VERSION,'noarch');

# Not included in rhel5 and fedora14
variable ACTIVEMQ_VERSION ?= error('ACTIVEMQ_VERSION variable undefined');
'/software/packages'=pkg_repl('activemq'       ,ACTIVEMQ_VERSION,'x86_64');
'/software/packages'=pkg_repl('activemq-client',ACTIVEMQ_VERSION,'x86_64');
