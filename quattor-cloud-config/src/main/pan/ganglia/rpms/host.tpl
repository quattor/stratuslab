${BUILD_INFO}
${LEGAL}

unique template ganglia/rpms/host;

variable GANGLIA_VERSION_NUM ?= '3.1.7-1';

'/software/packages' = {
  pkg_repl('ganglia-gmond', GANGLIA_VERSION_NUM, 'x86_64');
  #pkg_repl('ganglia', GANGLIA_VERSION_NUM, 'x86_64');
  pkg_repl('libganglia-3_1_0', GANGLIA_VERSION_NUM, 'x86_64');

  pkg_repl('libconfuse', '2.6-2.el5.rf', 'x86_64');
};
