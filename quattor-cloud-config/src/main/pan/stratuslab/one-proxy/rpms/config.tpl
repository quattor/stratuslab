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

unique template stratuslab/one-proxy/rpms/config;

include { 'default/stratuslab/package-versions' };

variable STRATUSLAB_AUTHN_PROXY_VERSION ?= error('STRATUSLAB_AUTHN_PROXY_VERSION variable undefined');
prefix "/software/packages";

'stratuslab-one-proxy' = nlist();
'stratuslab-authn-config' = nlist();

#
# Fetch CRL script is required to keep CRLs up-to-date.
#
variable FETCH_CRL_VERSION ?= error('FETCH_CRL_VERSION variable undefined');
