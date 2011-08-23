# #
# Software subject to following license(s):
#   Apache 2 License (http://www.opensource.org/licenses/apache2.0)
#   Copyright (c) Responsible Organization
#

# #
# Current developer(s):
#   Guillaume PHILIPPON <guillaume.philippon@lal.in2p3.fr>
#

# #
# Author(s): Jane SMITH, Joe DOE
#

# # 
# claudia, 1.1-SNAPSHOT, 20110622.1847.32
#

unique template components/claudia/config-rpm;

include { 'components/claudia/config-common' };

# Set prefix to root of component configuration.
prefix '/software/components/claudia';

# Install Quattor configuration module via RPM package.
'/software/packages' = pkg_repl('ncm-claudia','1.1-0.20110622.1847.32','noarch');
'dependencies/pre' ?= list('spma');

