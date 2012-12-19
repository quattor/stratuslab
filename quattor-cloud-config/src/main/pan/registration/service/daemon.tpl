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

unique template registration/service/daemon;

include { 'registration/variables' };
include { 'registration/rpms/daemon' };

# 
# Ensure that registration service is started.
#
include { 'components/chkconfig/config' };

'/software/components/chkconfig/service/registration/on' = '';
'/software/components/chkconfig/service/registration/startstop' = true;

#
# Also the LDAP database.
#
'/software/components/chkconfig/service/registration-ldap/on' = '';
'/software/components/chkconfig/service/registration-ldap/startstop' = true;

#
# Manage the registration configuration file.
#
include { 'components/filecopy/config' };

variable STRATUSLAB_REGISTRATION_CONFIG ?= <<EOF;
ldap.manager.password=changeme
admin.email=admin@example.org
mail.host=smtp.gmail.com
mail.port=465
mail.user=no-reply@example.org
mail.password=xxxxxx
mail.ssl=true
mail.debug=true
EOF

'/software/components/filecopy/services/{/etc/stratuslab/registration.cfg}' =
  nlist('config', format(file_contents('registration/service/daemon.cfg'),
                                  STRATUSLAB_REGISTRATION_LDAP_MANAGER_PWD,
                                  STRATUSLAB_REGISTRATION_ADMIN_EMAIL,
                                  STRATUSLAB_REGISTRATION_MAIL_HOST,
                                  STRATUSLAB_REGISTRATION_MAIL_PORT,
                                  STRATUSLAB_REGISTRATION_MAIL_USER,
                                  STRATUSLAB_REGISTRATION_MAIL_USER_PWD,
                                  STRATUSLAB_REGISTRATION_MAIL_SSL,
                                  STRATUSLAB_REGISTRATION_MAIL_DEBUG,
                  ),
        'restart', 'service registration restart',
        'perms', '0644');


include { 'common/iptables/base' };

'/software/components/iptables/filter/rules' = {
# Registration service
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'protocol', 'tcp',
    'match', 'tcp',
    'dst_port', '8444',
    'target', 'ACCEPT',
  ));
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'protocol', 'tcp',
    'source', '127.0.0.1',
    'match', 'tcp',
    'dst_port', '32000',
    'target', 'ACCEPT',
  ));
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'protocol', 'tcp',
    'match', 'tcp',
    'dst_port', '10389',
    'target', 'ACCEPT',
  ));
};

include { 'common/ldap/config' };
