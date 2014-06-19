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
# oned, 1.27-SNAPSHOT, 20120802.1133.41
#

unique template components/oned/config;

include {'components/oned/schema'};

'/software/packages'=pkg_repl('ncm-oned','1.27-0.20120802.1133.41','noarch');
'/software/components/oned/dependencies/pre' ?=  list ('spma', 'accounts');

'/software/components/oned/active' ?= true;
'/software/components/oned/dispatch' ?= true;
