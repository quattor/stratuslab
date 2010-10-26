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

template stratuslab-benchmarks;

# StratusLab benchmarks.
'/software/packages' = pkg_repl('stratuslab-benchmarks', '1.0-0.20100910.125052', 'x86_64');

# Initial dependencies.
'/software/packages' = pkg_repl('openmpi', '1.4-4.el5', 'i386');
'/software/packages' = pkg_repl('openmpi-devel', '1.4-4.el5', 'i386');
'/software/packages' = pkg_repl('openmpi', '1.4-4.el5', 'x86_64');
'/software/packages' = pkg_repl('openmpi-devel', '1.4-4.el5', 'x86_64');
'/software/packages' = pkg_repl('lapack', '3.0-37.el5', 'i386');
'/software/packages' = pkg_repl('lapack-devel', '3.0-37.el5', 'i386');
'/software/packages' = pkg_repl('lapack', '3.0-37.el5', 'x86_64');
'/software/packages' = pkg_repl('lapack-devel', '3.0-37.el5', 'x86_64');

# Additional dependencies.
'/software/packages' = pkg_repl('blas', '3.0-37.el5', 'i386');
'/software/packages' = pkg_repl('blas', '3.0-37.el5', 'x86_64');
'/software/packages' = pkg_repl('libgfortran', '4.1.2-48.el5', 'i386');
'/software/packages' = pkg_repl('libgomp', '4.4.0-6.el5', 'i386');
'/software/packages' = pkg_repl('libibcm', '1.0.5-1.el5', 'i386');
'/software/packages' = pkg_repl('libibcm', '1.0.5-1.el5', 'x86_64');
'/software/packages' = pkg_repl('libibverbs', '1.1.3-2.el5', 'i386');
'/software/packages' = pkg_repl('libibverbs', '1.1.3-2.el5', 'x86_64');
'/software/packages' = pkg_repl('libnes', '0.9.0-2.el5', 'i386');
'/software/packages' = pkg_repl('librdmacm', '1.0.10-1.el5', 'i386');
'/software/packages' = pkg_repl('librdmacm', '1.0.10-1.el5', 'x86_64');
'/software/packages' = pkg_repl('mpi-selector', '1.0.2-1.el5', 'noarch');
'/software/packages' = pkg_repl('numactl', '0.9.8-11.el5', 'i386');
'/software/packages' = pkg_repl('openib', '1.4.1-5.el5', 'noarch');
'/software/packages' = pkg_repl('openmpi-libs', '1.4-4.el5', 'i386');
'/software/packages' = pkg_repl('openmpi-libs', '1.4-4.el5', 'x86_64');

