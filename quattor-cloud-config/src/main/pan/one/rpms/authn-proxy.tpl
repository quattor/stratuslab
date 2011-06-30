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

unique template one/rpms/authn-proxy;

include { 'stratuslab-package-versions' };

#'/software/packages' = pkg_repl('stratuslab-cloud-proxy', STRATUSLAB_AUTHN_PROXY_VERSION, 'noarch');
'/software/packages' = pkg_repl('stratuslab-one-proxy', STRATUSLAB_AUTHN_PROXY_VERSION, 'noarch');

#
# Configuration module for the proxy.
#
'/software/packages' = pkg_repl('ncm-cloudauthn', '0.1-1', 'noarch');

#
# Fetch CRL script is required to keep CRLs up-to-date.
#
'/software/packages' = pkg_repl('fetch-crl','3.0.5-1.fc14','noarch');
