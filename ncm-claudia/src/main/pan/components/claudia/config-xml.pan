# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/claudia/config-xml;

include { 'components/claudia/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/claudia';

# Embed the Quattor configuration module into XML profile.
'code' = file_contents('components/claudia/claudia.pm'); 
