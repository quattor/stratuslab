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

unique template one/service/authn-proxy;

#
# Grid security environment is required.
#
include { 'common/security/cas' };
include { 'common/security/crl' };

#
# Include the necessary rpms. 
#
include { 'one/rpms/authn-proxy' };

# 
# Ensure that jetty servlet container is started
#
include { 'components/chkconfig/config' };

'/software/components/chkconfig/service/jetty/on' = '';
'/software/components/chkconfig/service/jetty/startstop' = true;

#
# Configure the users.
#
include { 'components/one_proxy/config' };

prefix '/software/components/one_proxy/config';

#
# Configuration for grid certificate and VOMS proxy authn.
#
'jaas/stratuslab-cert/login_modules/0' = 
  nlist(
    'name', 'eu.stratuslab.authn.CertLoginModule', 
    'flag', 'requisite',
    'options', nlist('file', '${jetty.home}/etc/login/login-cert.properties')
  );

#
# Configuration for username/password authn. from a file.
#
'jaas/stratuslab-pswd/login_modules/0' = 
  nlist(
    'name', 'org.eclipse.jetty.plus.jaas.spi.PropertyFileLoginModule', 
    'flag', 'sufficient',
    'options', nlist('file', '${jetty.home}/etc/login/login-pswd.properties')
  );

#
# Add something like this to allow authn. via an LDAP server. 
#  
#'jaas/stratuslab-pswd/login_modules/1' = 
#  nlist(
#    'name', 'org.eclipse.jetty.plus.jaas.spi.LdapLoginModule', 
#    'flag', 'sufficient',
#    'options',
#    nlist(
#      'debug', 'true',
#      'contextFactory', 'com.sun.jndi.ldap.LdapCtxFactory',
#      'hostname', 'ldap.example.org',
#      'port', '389',
#      'bindDn', 'cn=admin,ou=daemons,o=example',
#      'bindPassword', 'somepassword',
#      'authenticationMethod', 'simple',
#      'forceBindingLogin', 'true',
#      'userBaseDn', 'ou=people,o=example',
#      'userRdnAttribute', 'uid',
#      'userIdAttribute', 'uid',
#      'userPasswordAttribute', 'userPassword',
#      'userObjectClass', 'inetOrgPerson',
#      'roleBaseDn', 'ou=groups,o=example',
#      'roleNameAttribute', 'cn',
#      'roleMemberAttribute', 'uniqueMember',
#      'roleObjectClass', 'groupOfUniqueNames')
#  );
  

