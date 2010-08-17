${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/one-nfs-imports;

#
# Import the image repository, VM state area, and oneadmin home.
#
include { 'components/nfs/config' };

'/software/components/nfs/mounts' = append(
  nlist('device', ONE_NFS_SERVER + ':/var/lib/one/images',
        'mountpoint', '/var/lib/one/images',
        'fstype', 'nfs')
);
'/software/components/nfs/mounts' = append(
  nlist('device', ONE_NFS_SERVER + ':/var/lib/one/vms',
        'mountpoint', '/var/lib/one/vms',
        'fstype', 'nfs')
);
'/software/components/nfs/mounts' = append(
  nlist('device', ONE_NFS_SERVER + ':/home/oneadmin',
        'mountpoint', '/home/oneadmin',
        'fstype', 'nfs')
);

