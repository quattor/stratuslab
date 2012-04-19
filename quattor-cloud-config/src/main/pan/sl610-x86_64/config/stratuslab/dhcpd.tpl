unique template config/stratuslab/dhcpd;

'/software/packages'=pkg_repl('dhcp'        ,'4.1.1-19.P1.el6' ,'x86_64');
'/software/packages'=pkg_repl('tftp-server' ,'0.49-5.1.el6'    ,'x86_64');
'/software/packages'=pkg_repl('genisoimage' ,'1.1.9-11.el6'    ,'x86_64');
'/software/packages'=pkg_repl('mysql'       ,'5.1.52-1.el6_0.1','x86_64');
'/software/packages'=pkg_repl('rrdtool-perl','1.3.8-6.el6'     ,'x86_64');
'/software/packages'=pkg_repl('php-gd'      ,'5.3.3-3.el6'     ,'x86_64');
'/software/packages'=pkg_repl('rrdtool'     ,'1.3.8-6.el6'     ,'x86_64');
'/software/packages'=pkg_repl('ruby-mysql'  ,'2.8.2-1.el6'     ,'x86_64');
'/software/packages'=pkg_repl('glibc'       ,'2.12-1.25.el6'   ,'x86_64');

include { 'config/os/updates' };
