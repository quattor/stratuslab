@BUILD_INFO@
@LEGAL@

unique template components/@COMP@/config;

include {'components/@COMP@/schema'};

'/software/packages'=pkg_repl('@artifactId@','@rpm.version@-@rpm.release@','noarch');
'/software/components/@COMP@/dependencies/pre' ?=  list ('spma', 'accounts');

'/software/components/@COMP@/active' ?= true;
'/software/components/@COMP@/dispatch' ?= true;
