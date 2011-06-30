unique template config/quattor/client;

include { 'rpms/quattor' };

'/software/packages'=pkg_repl('cdp-listend','1.0.19-1','noarch');
'/software/packages'=pkg_repl('rpmt-py','1.0.8-1','noarch');

# OS errata and site specific updates
# Always reinclude. Must be last
include { 'config/os/updates' };
