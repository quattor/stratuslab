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

unique template one/service/authn-proxy;

#
# Grid security environment is required.
#
include { 'common/security/cas' };
include { 'common/security/crl' };

# 
# Ensure that jetty servlet container is started
#
include { 'components/chkconfig/config' };

'/software/components/chkconfig/service/jetty/on' = '';
'/software/components/chkconfig/service/jetty/startstop' = true;

