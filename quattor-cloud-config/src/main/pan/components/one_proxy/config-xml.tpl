# #
# Software subject to following license(s):
#   Apache 2 License (http://www.opensource.org/licenses/apache2.0)
#   Copyright (c) Centre National de la Recherche Scientifique
#

# #
# Current developer(s):
#   Charles LOOMIS <loomis@lal.in2p3.fr>
#

# 
# # 
# one_proxy, 1.26-SNAPSHOT, 20120329.1333.24
#

unique template components/one_proxy/config-xml;

include { 'components/one_proxy/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/one_proxy';

# Embed the Quattor configuration module into XML profile.
'code' = file_contents('components/one_proxy/one_proxy.pm'); 
