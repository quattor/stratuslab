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
# one_proxy, 1.6-SNAPSHOT, 20110609.1557.36
#

unique template components/one_proxy/config-rpm;

include { 'components/one_proxy/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/one_proxy';

# Install Quattor configuration module via RPM package.
'/software/packages' = pkg_repl('ncm-one_proxy','1.6-0.20110609.1557.36','noarch');
'dependencies/pre' ?= list('spma');

