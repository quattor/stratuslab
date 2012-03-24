unique template config/stratuslab/pat;

'/software/packages' = pkg_repl('ruby-sqlite3', '1.2.4-5.fc12', 'x86_64');

include { 'config/os/updates' };

