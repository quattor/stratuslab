unique template config/stratuslab/base;

include {
  if ( ! GLITE_DEPENDENCY ) {
    'config/stratuslab/base-without-glite';
  } else {
    null;
  };
};
'/software/packages'=pkg_repl('autofs','5.0.5-31.el6','x86_64');

# Add YUM downloadonly extension
"/software/packages"=pkg_repl("yum-plugin-downloadonly","1.1.30-6.el6","noarch");


