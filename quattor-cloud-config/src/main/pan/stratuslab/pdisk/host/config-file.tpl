unique template stratuslab/pdisk/host/config-file;

include { 'stratuslab/pdisk/variables' };

include { 'components/filecopy/config' };

'/software/components/filecopy/services/{/etc/stratuslab/pdisk-host.cfg}'=nlist(
  'config', format(file_contents('stratuslab/pdisk/host/pdisk-host.cfg'),
                    STRATUSLAB_PDISK_TYPE,
                    STRATUSLAB_PDISK_NFS_LOCATION,
                    STRATUSLAB_PDISK_ISCSIADM,
                    STRATUSLAB_PDISK_SUPER_USER,
                    STRATUSLAB_PDISK_SUPER_USER_PWD,
                    STRATUSLAB_PDISK_CURL,
                    STRATUSLAB_PDISK_REGISTER_FILENAME,
                    STRATUSLAB_PDISK_SCRIPT,
            ),
  'owner','root:root',
  'perms','0644',
);

'/software/components/filecopy/services/{/etc/stratuslab/pdisk-host.conf}'=nlist(
  'config', format(file_contents('stratuslab/pdisk/host/pdisk-host.conf'),
                    STRATUSLAB_PDISK_SUPER_USER,
                    STRATUSLAB_PDISK_SUPER_USER_PWD,
                    STRATUSLAB_PDISK_GET_TURL,
           ),
);
