unique template common/ldap/config;

include { 'components/filecopy/config' };

'/software/components/filecopy/services/{/etc/sysconfig/ldap}'=
nlist(
  'config',file_contents('common/ldap/sysconfig-ldap'),
  'owner', 'root:root',
  'perms', '0644'
);
