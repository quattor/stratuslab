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

unique template claudia/service/daemon;

include { 'claudia/rpms/daemon' };

include { 'components/claudia/config' };

'/software/components/claudia/sm-config/SiteRoot'      = 'lal.in2p3.fr';
'/software/components/claudia/sm-config/WASUP/WASUPLogin'   = 'oneadmin';
'/software/components/claudia/sm-config/WASUP/WASUPPassword' = 'secret';

include { 'components/accounts/config' };
# Create the 'oneadmin' user and 'cloud' group for OpenNebula.
'/software/components/accounts/groups/activemq/gid' = 9001;
'/software/components/accounts/users/activemq' = nlist(
  'uid', 9001,
  'groups', list('activemq'),
  'homeDir', '/home/activemq',
#  'createHome', false,
#  'createKeys', false
);

include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/tcloudd/on'  = '';
'/software/components/chkconfig/service/clothod/on'  = '';
'/software/components/chkconfig/service/activemq/on' = '';

#
# Fix activemq issue with permission directory
#
# We must find another way to fix it with quattor
#

include { 'components/filecopy/config' };

variable CONTENTS = <<EOF;
RUN_AS_USER=root
EOF
"/software/components/filecopy/services" =
  npush(escape("/etc/sysconfig/activemq"),
        nlist("config",CONTENTS,
              "restart","service activemq restart",
              "perms","0644"));


