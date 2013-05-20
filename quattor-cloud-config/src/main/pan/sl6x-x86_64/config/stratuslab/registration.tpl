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

unique template config/stratuslab/registration;

'/software/packages'=pkg_repl('glibc'             ,'2.12-1.25.el6','i686');
'/software/packages'=pkg_repl('openldap-clients'  ,'2.4.23-15.el6','x86_64');
'/software/packages'=pkg_repl('nss-softokn-freebl','3.12.9-11.el6','i686');

