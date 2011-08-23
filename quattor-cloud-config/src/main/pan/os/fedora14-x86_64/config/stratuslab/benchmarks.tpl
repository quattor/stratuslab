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

unique template config/stratuslab/benchmarks;

'/software/packages'=pkg_repl('blas-devel','3.2.2-2.fc14','x86_64');
'/software/packages'=pkg_repl('environment-modules','3.2.7b-7.fc13','x86_64');
'/software/packages'=pkg_repl('plpa-libs','1.3.2-4.fc13','x86_64');
'/software/packages'=pkg_repl('plpa-libs','1.3.2-4.fc13','i686');
'/software/packages'=pkg_repl('gcc-gfortran','4.5.1-4.fc14','x86_64');
'/software/packages'=pkg_repl('gcc','4.5.1-4.fc14','x86_64');

include { 'config/os/updates' };
