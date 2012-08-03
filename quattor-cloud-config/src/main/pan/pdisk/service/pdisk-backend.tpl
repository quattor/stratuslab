unique template pdisk/service/pdisk-backend;

include { 'pdisk/variables' };

include { 'components/filecopy/config' };

'/software/components/filecopy/services/{/etc/stratuslab/pdisk-backend.cfg}'=
  nlist('config',format(file_contents('pdisk/service/pdisk-backend.cfg'),
                   STRATUSLAB_PDISK_ISCSI_PROXIES,
                   STRATUSLAB_PDISK_PROXY_USERNAME,
                   STRATUSLAB_PDISK_PROXY_SSHKEYS,
                   STRATUSLAB_PDISK_PROXY_SECTIONS,
                ),
        'perms','0644',

  );
