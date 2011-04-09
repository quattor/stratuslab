# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/claudia/config-common;

include { 'components/claudia/schema' };

# Set prefix to root of component configuration.
prefix '/software/components/claudia';

#'version' = '1.0-SNAPSHOT';
#'package' = 'NCM::Component';

'active' ?= true;
'dispatch' ?= true;
