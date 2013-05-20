unique template stratuslab/web/config;

include { 'stratuslab/stratuslab/web/variables' };

include { 'components/filecopy/config' };

prefix '/software/components/filecopy';

'services/{/var/www/html/index.html}'= nlist(
	'config', format(file_contents('stratuslab/web/index.html'),
		STRATUSLAB_MARKETPLACE_HOST,
		STRATUSLAB_REGISTRATION_HOST,
		STRATUSLAB_PDISK_HOST,
		STRATUSLAB_PDISK_HOST,
		GANGLIA_MASTER,
		STRATUSLAB_ONE_HOST,
		),
);

'services/{/var/www/html/stratuslab-user.cfg}'= nlist(
	'config', format(file_contents('stratuslab/web/stratuslab-user.cfg'),
		STRATUSLAB_ONE_HOST,
		STRATUSLAB_MARKETPLACE_HOST,
  STRATUSLAB_MARKETPLACE_PROTOCOL,
		STRATUSLAB_PDISK_HOST,
		),
);
