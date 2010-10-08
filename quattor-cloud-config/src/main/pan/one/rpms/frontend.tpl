${BUILD_INFO}
${LEGAL}

unique template one/rpms/frontend;

'/software/packages' = pkg_repl('one','2.0-StratusLab.0.20101005.062607','x86_64');

# Include the benchmarks.
include { 'stratuslab-benchmarks' };

# StratusLab web monitor.
'/software/packages' = pkg_repl('stratuslab-web-monitor', '0.1-StratusLab.SNAPSHOT20100922152218', 'noarch');

# StratusLab client commands.
'/software/packages' = pkg_repl('stratuslab', '0.1-StratusLab.0.20100922.102134', 'noarch');

# MySQL client is compiled into oned (even if not used directly).
'/software/packages' = pkg_repl('mysql','5.0.77-4.el5_4.2','x86_64');

# Must have mkisofs for creating context images.
'/software/packages' = pkg_repl('mkisofs','2.01-10.7.el5','x86_64');

