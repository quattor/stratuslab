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
# oned, 1.26-SNAPSHOT, 20120323.2246.32
#

unique template components/oned/config;

include {'components/oned/schema'};

'/software/packages'=pkg_repl('ncm-oned','1.26-0.20120323.2246.32','noarch');
'/software/components/oned/dependencies/pre' ?=  list ('spma', 'accounts');

'/software/components/oned/active' ?= true;
'/software/components/oned/dispatch' ?= true;
