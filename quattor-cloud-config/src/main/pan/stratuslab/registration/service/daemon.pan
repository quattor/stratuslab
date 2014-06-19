unique template stratuslab/registration/service/daemon;

include { 'stratuslab/registration/variables' };

prefix '/software/packages';
'{stratuslab-registration}' ?= nlist();
'{openldap-servers}'        ?= nlist();
'{openldap-clients}'        ?= nlist();

include { 'common/nginx/config' };
# 
# Ensure that registration service is started.
#
include { 'components/chkconfig/config' };

'/software/components/chkconfig/service/registration/on' = '';
'/software/components/chkconfig/service/registration/startstop' = true;

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
  nlist('config', format(file_contents('stratuslab/registration/service/daemon.cfg'),
                                  STRATUSLAB_REGISTRATION_LDAP_MANAGER_DN,
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
    'dst_port', '9202',
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
