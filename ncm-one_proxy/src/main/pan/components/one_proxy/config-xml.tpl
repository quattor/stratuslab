# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/one_proxy/config-xml;

include { 'components/one_proxy/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/one_proxy';

# Embed the Quattor configuration module into XML profile.
'code' = file_contents('components/one_proxy/one_proxy.pm'); 
