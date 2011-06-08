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

'/software/components/claudia/reportClient-config/SiteRoot' = 'lal.in2p3.fr';

'/software/components/claudia/tcloud-config/onePassword' = '42d9d2622f862cd803d4395be2c1edd362213525';
'/software/components/claudia/tcloud-config/oneSshKey'   = 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAsqnlWWWXssptEAupZZrNJlheOjysx/qgrXLiEVcikb9GSLacXWT89MCd8VcsNXR9dObSNmPrJcCbbEF0bGzZcyy0SCJ9NiaBaIri8Em59cI7XncpKUjuqbbql6D7VZwfYU3w4gqAljNoqqXA9EhL3uf36p0gcKG8LyRIumQomP5Ymoe+wLo05FkXPQAp4+Jiz9VD1WeUCkfbhy3vwKiZI95yMA/Jfge7x4KaOIJHGuSNu7UgDE6TNvETYtz7yR1ND4B5y79KjvfmfOHvk3MoXjhEdosYfowiqdB8Hqv3Aea5hINSOyZc/Javhn+OjXbyNQf3meEMDMnb+86MVGGXIQ== root@telefonica-1';

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


