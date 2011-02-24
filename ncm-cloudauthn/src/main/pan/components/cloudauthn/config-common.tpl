# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/cloudauthn/config-common;

include { 'components/cloudauthn/schema' };

# Set prefix to root of component configuration.
prefix '/software/components/cloudauthn';

'version' = '0.1-SNAPSHOT';
'package' = 'NCM::Component';

'active' ?= true;
'dispatch' ?= true;
