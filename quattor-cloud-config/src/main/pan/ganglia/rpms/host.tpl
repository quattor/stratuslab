# ${BUILD_INFO}
#
# Created as part of the StratusLab project (http://stratuslab.eu)
#
# Copyright (c) 2010, Centre Nationale de la Recherche Scientifique
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

unique template ganglia/rpms/host;

variable GANGLIA_VERSION_NUM ?= '3.1.7-1';

'/software/packages' = {
  pkg_repl('ganglia-gmond', GANGLIA_VERSION_NUM, 'x86_64');
  #pkg_repl('ganglia', GANGLIA_VERSION_NUM, 'x86_64');
  pkg_repl('libganglia-3_1_0', GANGLIA_VERSION_NUM, 'x86_64');

  pkg_repl('libconfuse', '2.6-2.el5.rf', 'x86_64');
};
