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

unique template config/stratuslab/iscsi-target;

'/software/packages'=pkg_repl('perl-Config-General','2.44-1.el6','noarch');
'/software/packages'=pkg_repl('scsi-target-utils','1.0.14-2.el6','x86_64');
'/software/packages'=pkg_repl('libibverbs','1.1.4-2.el6','x86_64');
'/software/packages'=pkg_repl('librdmacm','1.0.10-2.el6','x86_64');
'/software/packages'=pkg_repl('libmthca','1.0.5-7.el6','x86_64');

