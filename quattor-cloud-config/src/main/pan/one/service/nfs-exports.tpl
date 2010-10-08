${BUILD_INFO}
${LEGAL}

unique template one/service/nfs-exports;

#
# Start the NFS daemons at boot. 
#
include {'components/chkconfig/config'};
'/software/components/chkconfig/service/nfs' = nlist('on', '', 'startstop', true);

#
# Export the image repository, VM state area, and oneadmin home.
#
# Use **filecopy component** here because the NFS component can't handle
# wildcards or slashes in IP addresses.
#
include { 'components/filecopy/config' };

variable ONE_NFS_FLAGS = 
  ONE_NFS_WILDCARD + '(async,no_subtree_check,rw,no_root_squash)' + "\n";

variable ONE_NFS_EXPORT_CONTENTS =
'/var/lib/one/images ' + ONE_NFS_FLAGS +
'/var/lib/one/vms ' + ONE_NFS_FLAGS + 
'/home/oneadmin ' + ONE_NFS_FLAGS;

'/software/components/filecopy/services/{/etc/exports}' = nlist(
  'config', ONE_NFS_EXPORT_CONTENTS,
  'owner', 'root',
  'group', 'root',
  'perms', '0644',
  'restart', 'service nfs restart'
);

