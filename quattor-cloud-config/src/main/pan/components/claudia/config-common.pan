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

unique template components/claudia/config-common;

include { 'components/claudia/schema' };

# Set prefix to root of component configuration.
prefix '/software/components/claudia';

#'version' = '1.0-SNAPSHOT';
#'package' = 'NCM::Component';

'active' ?= true;
'dispatch' ?= true;
