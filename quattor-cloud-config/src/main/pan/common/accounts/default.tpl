unique template common/accounts/default;

variable DISK_GROUP ?= 'disk';

# Create the 'oneadmin' user and 'cloud' group for OpenNebula.
include { 'components/accounts/config' };
'/software/components/accounts/' = {
  SELF['groups'][STRATUSLAB_UNIX_GROUP] = nlist(
    'gid', STRATUSLAB_UNIX_GROUP_ID,
  );
  SELF['users'][STRATUSLAB_UNIX_USER_ACCOUNT] = nlist(
    'uid', STRATUSLAB_UNIX_USER_ID,
    'groups', list(STRATUSLAB_UNIX_GROUP,DISK_GROUP),
    'homeDir', format("%s/%s", STRATUSLAB_UNIX_USER_HOME, STRATUSLAB_UNIX_USER_ACCOUNT),
    'createHome', false,
    'createKeys', false
  );
  SELF;
};
