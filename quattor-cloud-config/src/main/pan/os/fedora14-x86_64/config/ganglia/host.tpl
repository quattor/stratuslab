unique template config/ganglia/host;

variable GANGLIA_VERSION_NUM ?= '3.1.7-2.fc14';

'/software/packages'=pkg_repl('libconfuse', '2.6-3.fc12', 'x86_64');

include { 'config/os/updates' };
