unique template stratuslab/one/service/tm_stratuslab;

#
# Pdisk variables is needed to configure tm_stratuslab
#
include { 'stratuslab/pdisk/variables' };
include { 'stratuslab/marketplace/variables' };
include { 'stratuslab/one/variables' };

include { 'components/filecopy/config' };

variable CONTENTS = <<EOF;
[endorsers]

[images]

[checksums]

[validatemetadatafile]
activate=False
EOF

#'/software/components/filecopy/service'="";
'/software/components/filecopy/services/{/etc/stratuslab/policy.cfg}' =
  nlist('config',CONTENTS,
        'perms','0644');

'/software/components/filecopy/services/{/etc/stratuslab/stratuslab.cfg}' =
  nlist('config',format(file_contents('stratuslab/one/service/stratuslab.cfg'),
                          STRATUSLAB_ONE_USERNAME,
                          STRATUSLAB_ONE_PASSWORD,
                          STRATUSLAB_ONE_PORT,
                          STRATUSLAB_PDISK_HOST,
                          STRATUSLAB_PDISK_PORT,
                          STRATUSLAB_PDISK_PATH,
                          STRATUSLAB_PDISK_PUBLIC_BASE_URL,
                          STRATUSLAB_PDISK_TMP_DIR,
                          STRATUSLAB_PDISK_SUPER_USER,
                          STRATUSLAB_PDISK_ISCSI_DEVICE,
                          STRATUSLAB_PDISK_ROOT_PRIVATE_KEY,
                          STRATUSLAB_PDISK_TYPE,
                          STRATUSLAB_PDISK_NFS_DIRECTORY,
                          'https://'+STRATUSLAB_MARKETPLACE_HOST,
                          STRATUSLAB_QUARANTINE_PERIOD,
                 ),
        'perms','0644');

variable CONTENTS = <<EOF;
[default]
EOF

variable CONTENTS = CONTENTS+"endpoint = "+FULL_HOSTNAME+"\n";
variable CONTENTS = CONTENTS+"username = "+STRATUSLAB_PDISK_SUPER_USER+"\n";
variable CONTENTS = CONTENTS+"password = "+STRATUSLAB_PDISK_SUPER_USER_PWD+"\n";
variable CONTENTS = CONTENTS+"pdisk_endpoint = "+STRATUSLAB_PDISK_HOST+"\n";
variable CONTENTS = CONTENTS+"marketplace_endpoint = "+STRATUSLAB_MARKETPLACE_PROTOCOL+"://"+STRATUSLAB_MARKETPLACE_HOST+"\n";

'/software/components/filecopy/services/{/home/oneadmin/.stratuslab/stratuslab-user.cfg}' =
  nlist('config',CONTENTS,
	'owner', 'oneadmin:cloud',
        'perms','0644');

