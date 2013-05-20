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

'/software/packages'=pkg_repl('blas-devel'         ,'3.2.1-4.el6'  ,'x86_64');
'/software/packages'=pkg_repl('environment-modules','3.2.7b-6.el6' ,'x86_64');
'/software/packages'=pkg_repl('plpa-libs'          ,'1.3.2-2.1.el6','x86_64');
'/software/packages'=pkg_repl('gcc-gfortran'       ,'4.4.5-6.el6'  ,'x86_64');
'/software/packages'=pkg_repl('gcc'                ,'4.4.5-6.el6'  ,'x86_64');

'/software/packages' = pkg_repl( 'openmpi'       , '1.4.3-1.1.el6'  , 'x86_64' );
'/software/packages' = pkg_repl( 'openmpi-devel' , '1.4.3-1.1.el6'  , 'x86_64' );

'/software/packages' = pkg_repl( 'lapack'        , '3.2.1-4.el6'  , 'x86_64' );
'/software/packages' = pkg_repl( 'lapack-devel'  , '3.2.1-4.el6'  , 'x86_64' );

'/software/packages' = pkg_repl( 'blas'          , '3.2.1-4.el6'  , 'x86_64' );
'/software/packages' = pkg_repl( 'libgfortran'   , '4.4.5-6.el6'  , 'x86_64' );
'/software/packages' = pkg_repl( 'libgomp'       , '4.4.5-6.el6'  , 'x86_64' );
'/software/packages' = pkg_repl( 'libibcm'       , '1.0.5-2.el6'  , 'x86_64' );
'/software/packages' = pkg_repl( 'libibverbs'    , '1.1.4-2.el6'  , 'x86_64' );
'/software/packages' = pkg_repl( 'librdmacm'     , '1.0.10-2.el6' , 'x86_64' );
'/software/packages' = pkg_repl( 'numactl'       , '2.0.3-9.el6'  , 'x86_64' );

'/software/packages' = pkg_repl( 'dhcp'          , '4.1.1-19.P1.el6'  , 'x86_64' );

