# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/cloudauthn/config-rpm;

include { 'components/cloudauthn/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/cloudauthn';

# Install Quattor configuration module via RPM package.
'/software/packages' = pkg_repl('ncm-cloudauthn','0.1-SNAPSHOT-1','noarch');
'dependencies/pre' ?= list('spma');

