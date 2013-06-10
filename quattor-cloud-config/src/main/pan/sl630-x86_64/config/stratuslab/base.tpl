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

'/software/packages'=pkg_repl('autofs','5.0.5-54.el6','x86_64');

# Add YUM downloadonly extension
"/software/packages"=pkg_repl("yum-plugin-downloadonly","1.1.30-14.el6","noarch");

include { 'rpms/print_client' };
include { 'rpms/x11' };
include { 'rpms/dial_up' };
include { 'rpms/console_internet' };
include { 'rpms/graphics' };
include { 'rpms/emacs' };
include { 'rpms/directory_client' };
include { 'rpms/directory_server' }; # for openldap-servers
include { 'rpms/development' };
include { 'rpms/additional_devel' };
include { 'rpms/legacy_unix'};
include {'rpms/system_admin_tools'};#some RPMS were previously in base_x

#
# Add some RPMs normally part of SLC but not included in any group in SL
#

'/software/packages' = pkg_repl('perl-SOAP-Lite','0.710.10-2.el6','noarch');
# Dependencies for perl-SOAP-Lite
'/software/packages'=pkg_repl('perl-Authen-SASL',          '2.13-2.el6',     'noarch');
'/software/packages'=pkg_repl('perl-IO-Socket-SSL',        '1.31-2.el6',     'noarch');
'/software/packages'=pkg_repl('perl-Net-Jabber',           '2.0-12.el6',     'noarch');
"/software/packages"=pkg_repl("perl-Time-modules",         "2006.0814-5.el6","noarch");
'/software/packages'=pkg_repl('perl-MIME-Lite',            '3.027-2.el6',    'noarch');
'/software/packages'=pkg_repl('perl-GSSAPI',               '0.26-5.el6',     'x86_64');
'/software/packages'=pkg_repl('perl-Net-SSLeay',           '1.35-9.el6',     'x86_64');
'/software/packages'=pkg_repl('perl-Net-XMPP',             '1.02-8.el6',     'noarch');
'/software/packages'=pkg_repl('perl-XML-Stream',           '1.22-12.el6',    'noarch');
"/software/packages"=pkg_repl("perl-Net-DNS",              "0.65-4.el6",     "x86_64");
'/software/packages'=pkg_repl('perl-LDAP',                 '0.40-1.el6',     'noarch');
'/software/packages'=pkg_repl('perl-Convert-ASN1',         '0.22-1.el6',     'noarch');
'/software/packages'=pkg_repl('perl-XML-SAX',              '0.96-7.el6',     'noarch');
'/software/packages'=pkg_repl('perl-XML-NamespaceSupport', '1.10-3.el6',     'noarch');
'/software/packages'=pkg_repl('perl-TimeDate',             '1.16-11.1.el6',  'noarch');
"/software/packages"=pkg_repl("perl-XML-Filter-BufferText","1.01-8.el6",      "noarch");
"/software/packages"=pkg_repl("perl-Text-Iconv",           "1.7-6.el6",      "x86_64");
"/software/packages"=pkg_repl("perl-Net-LibIDN",           "0.12-3.el6",     "x86_64");
"/software/packages"=pkg_repl("perl-XML-SAX-Writer",       "0.50-8.el6",     "noarch");
"/software/packages"=pkg_repl("perl-XML-LibXML",           "1.70-5.el6",     "x86_64");
"/software/packages"=pkg_repl("perl-Authen-SASL",          "2.13-2.el6",     "noarch");
"/software/packages"=pkg_repl("perl-Digest-HMAC",          "1.01-22.el6",    "noarch");
"/software/packages"=pkg_repl("perl-Digest-SHA1",          "2.12-2.el6",     "x86_64");
'/software/packages'=pkg_repl('perl-Error',                '0.17015-4.el6',  'noarch');
"/software/packages"=pkg_repl("perl-GSSAPI",               "0.26-5.el6",     "x86_64");
"/software/packages"=pkg_repl("perl-IO-Socket-SSL",        "1.31-2.el6",     "noarch");
"/software/packages"=pkg_repl("perl-Net-LibIDN",           "0.12-3.el6",     "x86_64");
"/software/packages"=pkg_repl("perl-Net-SMTP-SSL",         "1.01-4.el6",     "noarch");
"/software/packages"=pkg_repl("perl-Net-SSLeay",           "1.35-9.el6",     "x86_64");
"/software/packages"=pkg_repl("perl-TermReadKey",          "2.30-13.el6",    "x86_64");
"/software/packages"=pkg_repl('perl-Email-Date-Format',    '1.002-5.el6',    'noarch');
"/software/packages"=pkg_repl("perl-MIME-Types",           "1.28-2.el6",     "noarch");
"/software/packages"=pkg_repl("perl-MailTools",            "2.04-4.el6",     "noarch");
'/software/packages'=pkg_repl('ecj','3.4.2-6.el6','x86_64');

include { 'config/os/updates' };
