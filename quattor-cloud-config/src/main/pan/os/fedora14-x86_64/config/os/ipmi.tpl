unique template config/os/ipmi;

'/software/packages'=pkg_repl('OpenIPMI'       ,'2.0.18-4.fc14','x86_64');
'/software/packages'=pkg_repl('OpenIPMI-gui'   ,'2.0.18-4.fc14','x86_64');
'/software/packages'=pkg_repl('OpenIPMI-libs'  ,'2.0.18-4.fc14','x86_64');
'/software/packages'=pkg_repl('OpenIPMI-perl'  ,'2.0.18-4.fc14','x86_64');
'/software/packages'=pkg_repl('OpenIPMI-python','2.0.18-4.fc14','x86_64');
'/software/packages'=pkg_repl('ipmitool'       ,'1.8.11-5.fc14','x86_64');
'/software/packages'=pkg_repl('net-snmp-libs'  ,'5.5-20.fc14'  ,'x86_64');
'/software/packages'=pkg_repl('lm_sensors-libs','3.1.2-2.svn5857.fc14','x86_64');

include { 'config/os/updates' };
