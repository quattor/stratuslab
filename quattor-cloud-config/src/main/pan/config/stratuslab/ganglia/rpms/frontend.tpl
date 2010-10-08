${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/ganglia/rpms/frontend;

variable GANGLIA_VERSION_NUM ?= '3.1.7-1';

'/software/packages' = {
  pkg_repl('ganglia-gmetad', GANGLIA_VERSION_NUM, 'x86_64');
  pkg_repl('ganglia-gmond', GANGLIA_VERSION_NUM, 'x86_64');
  pkg_repl('ganglia-web', GANGLIA_VERSION_NUM, 'noarch');
  #pkg_repl('ganglia', GANGLIA_VERSION_NUM, 'x86_64');
  pkg_repl('libganglia-3_1_0', GANGLIA_VERSION_NUM, 'x86_64');

  pkg_repl('libconfuse', '2.6-2.el5.rf', 'x86_64');
  pkg_repl('php-gd', '5.1.6-27.el5', 'x86_64');
  pkg_repl('rrdtool', '1.3.8-2.el5.rf', 'x86_64');
  pkg_repl('perl-rrdtool', '1.3.8-2.el5.rf', 'x86_64');
};

