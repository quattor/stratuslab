unique template one/service/tm_stratuslab;

variable STRATUSLAB_PDISK_HOST ?= error("STRATUSLAB_PDISK_HOST must be declared");
variable STRATUSLAB_PDISK_SUPER_USER ?= 'pdisk';
variable STRATUSLAB_PDISK_SUPER_USER_PWD ?= error("STRATUSLAB_PDISK_SUPER_USER_PWD must be declared");
variable STRATUSLAB_PDISK_DEVICE ?= error('STRATUSLAB_PDISK_DEVICE must be declared');
variable STRATUSLAB_PDISK_TMP_DIR ?= '/var/lib/one/images/';

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

variable CONTENTS = <<EOF;
[persistent_disks]
EOF

variable CONTENTS = CONTENTS+"persistent_disk_ip = "+STRATUSLAB_PDISK_HOST+"\n";
variable CONTENTS = CONTENTS+"persistent_disk_temp_store = "+STRATUSLAB_PDISK_TMP_DIR+"\n";
variable CONTENTS = CONTENTS+"persistent_disk_cloud_service_user = "+STRATUSLAB_PDISK_SUPER_USER+"\n";
variable CONTENTS = CONTENTS+"persistent_disk_lvm_device = "+STRATUSLAB_PDISK_DEVICE+"\n";

'/software/components/filecopy/services/{/etc/stratuslab/stratuslab.cfg}' =
  nlist('config',CONTENTS,
        'perms','0644');

variable CONTENTS = <<EOF;
[user]
EOF

variable CONTENTS = CONTENTS+"endpoint = "+FULL_HOSTNAME+"\n";
variable CONTENTS = CONTENTS+"username = "+STRATUSLAB_PDISK_SUPER_USER+"\n";
variable CONTENTS = CONTENTS+"password = "+STRATUSLAB_PDISK_SUPER_USER_PWD+"\n";
variable CONTENTS = CONTENTS+"pdisk_endpoint = "+STRATUSLAB_PDISK_HOST+"\n";

'/software/components/filecopy/services/{/home/oneadmin/.stratuslab/stratuslab-user.cfg}' =
  nlist('config',CONTENTS,
	'owner', 'oneadmin:cloud',
        'perms','0644');

