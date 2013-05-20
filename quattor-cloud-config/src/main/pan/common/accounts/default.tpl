unique template common/accounts/default;

variable DISK_GROUP ?= 'disk';

# Create the 'oneadmin' user and 'cloud' group for OpenNebula.
include { 'components/accounts/config' };
'/software/components/accounts/' = {

  SELF['groups'][ONE_GROUP] = nlist(
    'gid', ONE_GROUP_ID,
  );
  SELF['users'][ONE_USER] = nlist(
    'uid', ONE_USER_ID,
    'groups', list(ONE_GROUP,DISK_GROUP),
    'homeDir', format("%s/%s", ONE_HOME, ONE_USER),
    'createKeys', false,
    'createHome', false,
  );

  SELF;
};
