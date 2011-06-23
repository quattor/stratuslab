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

variable CLAUDIA_VERSION ?= '0.1.5-0.20110622.123800';

'/software/packages'=pkg_repl('claudia-client-rpm',CLAUDIA_VERSION,'noarch');
'/software/packages'=pkg_repl('clotho-rpm',CLAUDIA_VERSION,'noarch');
'/software/packages'=pkg_repl('tcloud-server-rpm',CLAUDIA_VERSION,'noarch');

# Not included in rhel5 and fedora14
'/software/packages'=pkg_repl('activemq','5.4.2-1.el5','x86_64');
'/software/packages'=pkg_repl('activemq-client','5.4.2-1.el5','x86_64');
