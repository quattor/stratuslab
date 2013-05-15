unique template config/stratuslab/base;

variable AII_OSINSTALL_BASE_PACKAGES ?= list (
    "perl-LC",
    "perl-AppConfig-caf",
    "perl-Proc-ProcessTable",
    "perl-CAF",
    "perl-common-sense",
    "perl-JSON-XS",
    "perl-CDB_File",
    "ccm",
    "ncm-ncd",
    "rpmt-py",
    "spma",
    "ncm-spma",
    "cdp-listend",
    "ncm-cdispd",
);

variable AII_OSINSTALL_PACKAGES ?= list (
    "openssh",
    "openssh-server",
    "wget",
    "perl-URI",
    "perl-CGI",
    "perl-libwww-perl",
    "perl-XML-Parser",
    "perl-DBI",
    "perl-Crypt-SSLeay",
    "perl-Template-Toolkit",
    "perl-Compress-Zlib",
    "perl-parent",
    "perl-GSSAPI",
    "perl-libwww-perl",
    "perl-TeX-Hyphen",
    "perl-Text-Reform",
    "perl-Text-Autoformat",
    "perl-Pod-POM",
    "lsof",
    "perl-IO-String",
    "curl",
);

include {
  if ( ! GLITE_DEPENDENCY ) {
    'config/stratuslab/base-without-glite';
  } else {
    null;
  };
};
'/software/packages'=pkg_repl('autofs','5.0.5-54.el6','x86_64');

# Add YUM downloadonly extension
"/software/packages"=pkg_repl("yum-plugin-downloadonly","1.1.30-14.el6","noarch");


include { 'config/os/updates' };
