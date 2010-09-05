${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/one-frontend;

'/software/packages'=pkg_repl('one','2.0-StratusLab.0.20100813.084828','x86_64');

# StratusLab client commands.
'/software/packages'=pkg_repl('stratuslab', '0.1-StratusLab.0.20100819.151632', 'noarch');

# MySQL client is compiled into oned (even if not used directly).
'/software/packages'=pkg_repl('mysql','5.0.77-4.el5_4.2','x86_64');

# Must have mkisofs for creating context images.
'/software/packages'=pkg_repl('mkisofs','2.01-10.7.el5','x86_64');


