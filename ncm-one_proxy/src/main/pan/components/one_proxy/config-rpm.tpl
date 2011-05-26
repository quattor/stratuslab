# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/one_proxy/config-rpm;

include { 'components/one_proxy/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/one_proxy';

# Install Quattor configuration module via RPM package.
'/software/packages' = pkg_repl('ncm-one_proxy','${no-snapshot-version}-${RELEASE}','noarch');
'dependencies/pre' ?= list('spma');

