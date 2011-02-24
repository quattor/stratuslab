# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

unique template components/cloudauthn/config-xml;

include { 'components/cloudauthn/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/cloudauthn';

# Embed the Quattor configuration module into XML profile.
'code' = file_contents('components/cloudauthn/cloudauthn.pm'); 
