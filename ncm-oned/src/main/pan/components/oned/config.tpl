# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/oned/config;

include {'components/oned/schema'};

'/software/packages'=pkg_repl('ncm-oned','${no-snapshot-version}-${RELEASE}','noarch');
'/software/components/oned/dependencies/pre' ?=  list ('spma', 'accounts');

'/software/components/oned/active' ?= true;
'/software/components/oned/dispatch' ?= true;
