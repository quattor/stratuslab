# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/claudia/config-rpm;

include { 'components/claudia/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/claudia';

# Install Quattor configuration module via RPM package.
'/software/packages' = pkg_repl('ncm-claudia','${no-snapshot-version}-${RELEASE}','noarch');
'dependencies/pre' ?= list('spma');

