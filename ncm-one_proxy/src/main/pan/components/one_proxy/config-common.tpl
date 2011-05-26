# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/one_proxy/config-common;

include { 'components/one_proxy/schema' };

# Set prefix to root of component configuration.
prefix '/software/components/one_proxy';

#'version' = '0.1-SNAPSHOT';
#'package' = 'NCM::Component';

'active' ?= true;
'dispatch' ?= true;
