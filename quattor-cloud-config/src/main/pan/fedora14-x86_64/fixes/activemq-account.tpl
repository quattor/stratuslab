unique template fixes/activemq-account;

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
