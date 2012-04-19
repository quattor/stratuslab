unique template one/service/users;

#
# Configure the users and authentication mechanisms.
#
include { 'components/one_proxy/config' };

prefix '/software/components/one_proxy/config';

# LAL StratusLab Admin
'users_by_pswd/username/password'     = 'MD5:hashed_pswd';

'users_by_cert/{CN=XXX YYY, O=XXX, DC=XXXX, DC=XX}/groups' = list('cloud-access');

'jaas/stratuslab-pswd/login_modules' = append(
  nlist(
    'name',    'org.eclipse.jetty.plus.jaas.spi.LdapLoginModule',
    'flag',    'sufficient',
    'options', nlist(
      'debug',                'true',
      'contextFactory',       'com.sun.jndi.ldap.LdapCtxFactory',
      'hostname',             '',
      'port',                 '10389',
      'bindDn',               'uid=admin,ou=system',
      'bindPassword',         '',
      'authenticationMethod', 'simple',
      'forceBindingLogin',    'true',
      'userBaseDn',           'ou=users,o=cloud',
      'userRdnAttribute',     'uid',
      'userIdAttribute',      'uid',
      'userPasswordAttribute','userPassword',
      'userObjectClass',      'inetOrgPerson',
      'roleBaseDn',           'ou=groups,o=cloud',
      'roleNameAttribute',    'cn',
      'roleMemberAttribute',  'uniqueMember',
      'roleObjectClass',      'groupOfUniqueNames'
    ),
  ),
);
