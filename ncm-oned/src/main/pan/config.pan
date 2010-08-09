################################################################################
#
# VERSION:    @VERSION@, @DATE@
# AUTHOR:     @AUTHOR@
# MAINTAINER: @MAINTAINER@
# LICENSE:    @LICENSE@
#
################################################################################
# Coding style: emulate <TAB> characters with 4 spaces, thanks!
################################################################################
unique template components/@COMP@/config;

include {'components/@COMP@/schema'};

'/software/packages'=pkg_repl('@NAME@','@VERSION@-@RELEASE@','noarch');
'/software/components/@COMP@/dependencies/pre' ?=  list ('spma');

'/software/components/@COMP@/active' ?= true;
'/software/components/@COMP@/dispatch' ?= true;
