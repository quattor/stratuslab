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

unique template stratuslab/one-proxy/config;

include { 'stratuslab/one-proxy/variables' };

#
# Grid security environment is required.
#
include { if_exists('common/security/cas') };
include { if_exists('security/cas') };
include { 'features/fetch-crl/config' };

#
# Include the necessary rpms. 
#
include { 'stratuslab/one-proxy/rpms/'+STRATUSLAB_SPMA_VERSION+'/config' };

# 
# Ensure that jetty servlet container is started
#
include { 'components/chkconfig/config' };

'/software/components/chkconfig/service/one-proxy/on' = '';
'/software/components/chkconfig/service/one-proxy/startstop' = true;


include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/fetch-crl-boot/on" = "2345";
"/software/components/chkconfig/service/fetch-crl-boot/startstop" = true;
"/software/components/chkconfig/service/fetch-crl-cron/on" = "2345";
"/software/components/chkconfig/service/fetch-crl-cron/startstop" = true;


#
# Configure the users.
#
include { 'components/one_proxy/config' };

#
# Load pdisk variable, pdisk account must be added
#
include { 'stratuslab/pdisk/variables' };

#
# Add one-proxy to be restarted when a modification is applied
#
'/software/components/one_proxy/daemon'=append('one-proxy');

prefix '/software/components/one_proxy/config';

#
# Configuration for grid certificate and VOMS proxy authn.
#
'jaas/stratuslab-cert/login_modules' = append(
    nlist('name',    'eu.stratuslab.authn.CertLoginModule', 
          'flag',    'requisite',
          'options', nlist('file', '/etc/stratuslab/authn/login-cert.properties')
    )
);

#
# Configuration for username/password authn. from a file.
#
'jaas/stratuslab-pswd/login_modules' = append(
  nlist('name',    'org.eclipse.jetty.plus.jaas.spi.PropertyFileLoginModule', 
        'flag',    'sufficient',
        'options', nlist('file', '/etc/stratuslab/authn/login-pswd.properties')
  )
);

'users_by_pswd/'=npush(STRATUSLAB_PDISK_SUPER_USER,nlist('password',STRATUSLAB_PDISK_SUPER_USER_PWD));  

#
# Allow LDAP authentication.
#

#'jaas/stratuslab-pswd/login_modules' =append(
#    nlist(
#    'name', 'org.eclipse.jetty.plus.jaas.spi.LdapLoginModule',
#    'flag', 'sufficient',
#    'options', nlist('debug',                'true',
#                     'contextFactory',       'com.sun.jndi.ldap.LdapCtxFactory',
#                     'hostname',             STRATUSLAB_LDAP_HOST,
#                     'port',                 STRATUSLAB_LDAP_PORT,
#                     'bindDn',               STRATUSLAB_LDAP_BIND_DN,
#                     'bindPassword',         STRATUSLAB_LDAP_BIND_PWD,
#                     'authenticationMethod', 'simple',
#                     'forceBindingLogin',    'true',
#                     'userBaseDn',           STRATUSLAB_USER_BASE_DN,
#                     'userRdnAttribute',     'uid',
#                     'userIdAttribute',      'uid',
#                     'userPasswordAttribute','userPassword',
#                     'userObjectClass',      'inetOrgPerson',
#                     'roleBaseDn',           STRATUSLAB_LDAP_ROLE_DN,
#                     'roleNameAttribute',    'cn',
#                     'roleMemberAttribute',  'uniqueMember',
#                     'roleObjectClass',      'groupOfUniqueNames'
#               )
#    )
#);

include { 'one/service/users' };
