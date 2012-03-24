unique template config/stratuslab/base;

'/software/packages'=pkg_repl('autofs','5.0.5-31.el6','x86_64');

include { 'config/os/updates' };