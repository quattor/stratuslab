unique template config/quattor/client;

include { 'rpms/quattor' };

'/software/packages'=pkg_repl('cdp-listend','1.0.19-1','noarch');
'/software/packages'=pkg_repl('rpmt-py','1.0.8-1','noarch');

'/software/packages'=pkg_repl('perl-Compress-Raw-Zlib','2.030-1.fc14','x86_64');
'/software/packages'=pkg_repl('perl-XML-Parser','2.36-9.fc14','x86_64');
'/software/packages'=pkg_repl('perl-libwww-perl','5.836-1.fc14','noarch');

# OS errata and site specific updates
# Always reinclude. Must be last
include { 'config/os/updates' };
