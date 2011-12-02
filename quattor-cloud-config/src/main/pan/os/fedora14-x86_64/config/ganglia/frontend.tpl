unique template config/ganglia/frontend;

variable GANGLIA_VERSION_NUM ?= '3.1.7-2.fc14';

'/software/packages' = {
  pkg_repl('libconfuse','2.6-3.fc12', 'x86_64');
  pkg_repl('php-gd',    '5.3.6-1.fc14', 'x86_64');
  pkg_repl('php-common','5.3.6-1.fc14', 'x86_64');
  pkg_repl('rrdtool',   '1.4.4-1.fc14', 'x86_64');
  pkg_repl('ruby',      '1.8.7.352-1.fc14','x86_64');
  pkg_repl('ruby-libs', '1.8.7.352-1.fc14','x86_64');
};

'/software/packages'=pkg_repl('expat','2.0.1-10.fc13','x86_64');
'/software/packages'=pkg_repl('dejavu-sans-mono-fonts','2.32-1.fc14','noarch');
'/software/packages'=pkg_repl('dejavu-lgc-sans-mono-fonts','2.32-1.fc14','noarch');
'/software/packages'=pkg_repl('dejavu-fonts-common','2.32-1.fc14','noarch');
'/software/packages'=pkg_repl('t1lib','5.1.2-6.fc14','x86_64');
'/software/packages'=pkg_repl('fontpackages-filesystem','1.44-1.fc14','noarch');

include { 'config/os/updates' };
