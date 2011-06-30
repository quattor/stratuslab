# Define OS base configuration of any type of gLite servers.

template config/glite/3.2/base;


variable OS_BASE_CONFIG_SITE ?= null;

variable KERNEL_VARIANT ?= "";

#
# Kernel version and CPU architecture
#
include { 'os/kernel_version_arch' };
"/system/kernel/version" = KERNEL_VERSION;

# Default architecture to use for gLite, if several architectures are
# supported for a service.
# This variable can be overriden at a site level or in a profile to
# force a specific architecture (e.g. i686 on 64-bit machine)
variable PKG_ARCH_GLITE ?= PKG_ARCH_DEFAULT;


#
# Predefined groups.
#
include { 'rpms/core' };
include { 'rpms/base' };
include { 'rpms/printing' };
include { 'rpms/base_x' };
include { 'rpms/dial_up' };
include { 'rpms/text_internet' };
include { 'rpms/graphics' };
include { 'rpms/editors' };
include { 'rpms/directory_server' }; # for openldap-servers
include { 'rpms/development_libs' };
include { 'rpms/development_tools' };
include { 'rpms/perl' };
include { 'rpms/brl' };
include { 'rpms/tcl' };
include { 'rpms/autofs' };


#
# Add some RPMs normally part of SLC but not included in any group in SL
#

#'/software/packages'=pkg_repl('perl-SOAP-Lite','0.710.10-2.el6','noarch');
#'/software/packages'=pkg_repl('perl-Authen-SASL','2.13-2.el6','noarch');
'/software/packages'=pkg_repl('perl-IO-Socket-SSL','1.33-2.fc14','noarch');
#'/software/packages'=pkg_repl('perl-Net-Jabber','2.0-12.el6','noarch');
#'/software/packages'=pkg_repl('perl-MIME-Lite','3.027-2.el6','noarch');
#'/software/packages'=pkg_repl('perl-GSSAPI','0.26-5.el6',PKG_ARCH_GLITE);
'/software/packages'=pkg_repl('perl-Net-SSLeay','1.36-2.fc14',PKG_ARCH_GLITE);
#'/software/packages'=pkg_repl('perl-Net-XMPP','1.02-8.el6','noarch');
#'/software/packages'=pkg_repl('perl-XML-Stream','1.22-12.el6','noarch');
#'/software/packages'=pkg_repl('perl-LDAP','0.40-1.el6','noarch');
#'/software/packages'=pkg_repl('perl-Convert-ASN1','0.22-1.el6','noarch');
#'/software/packages'=pkg_repl('perl-XML-SAX','0.96-7.el6','noarch');
#'/software/packages'=pkg_repl('perl-XML-NamespaceSupport','1.10-3.el6','noarch');
'/software/packages'=pkg_repl('perl-TimeDate','1.20-2.fc14','noarch');
'/software/packages'=pkg_repl('perl-MailTools', '2.07-1.fc14', 'noarch');
'/software/packages'=pkg_repl('perl-Digest-HMAC','1.02-3.fc14','noarch');
'/software/packages'=pkg_repl('perl-Digest-SHA1','2.12-4.fc14',PKG_ARCH_DEFAULT);


'/software/packages'=pkg_repl('boost','1.44.0-1.fc14',PKG_ARCH_GLITE);
'/software/packages'=pkg_repl('expat','2.0.1-10.fc13',PKG_ARCH_GLITE);
'/software/packages'=pkg_repl('libstdc++','4.5.1-4.fc14',PKG_ARCH_GLITE);

'/software/packages' = pkg_repl('tk','8.5.8-2.fc14',PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl('tkinter','2.7-8.fc14.1', PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl('tix','8.4.3-5.fc13',PKG_ARCH_DEFAULT);
"/software/packages" = pkg_repl("words", "3.0-16.fc12", "noarch");

#glite-wms-wmproxy-api-python 3.3.1-1.sl5 needs pyOpenSSL >= 0.6
"/software/packages"=pkg_repl("pyOpenSSL","0.9-2.fc14",PKG_ARCH_DEFAULT);

'/software/packages'=pkg_repl('libgcj','4.5.1-4.fc14',PKG_ARCH_DEFAULT);
#'/software/packages'=pkg_repl('libgcj-devel','4.5.1-4.fc14',PKG_ARCH_DEFAULT);

'/software/packages' = pkg_del('sysreport');
'/software/packages' = pkg_del('yum-conf-5x');


#
# Remove conflicting useless RPMs.
#
"/software/packages"=pkg_del("octave");
"/software/packages"=pkg_del("gcc-java");
"/software/packages"=pkg_del("perl-DBI","","i686");
"/software/packages"=pkg_del("kernel-module-ipw3945-"+KERNEL_VERSION);
"/software/packages"=pkg_del("ipw3945-firmware");
'/software/packages'=pkg_del('sysreport');
'/software/packages'=pkg_del('yum-conf-5x');

'/software/packages'=pkg_del('DeviceKit-power');
'/software/packages'=pkg_del('NetworkManager');

# Add very usefull RPMs
'/software/packages'=pkg_repl('lvm2','2.02.73-3.fc14','x86_64');
'/software/packages'=pkg_repl('lvm2-libs','2.02.73-3.fc14','x86_64');

# OS errata and site specific updates
include { 'config/os/updates' };


'/software/components/chkconfig/service/network/on'='12345';


# Configure Java according to gLite/OS version
include { OS_NS_OS + 'java' };

# hplip - HP Linux Imaging and Printing 
# pcsd -  PC SmartCard Daemon
# gpm - a cut and paste utility and mouse server for virtual consoles
variable OS_UNWANTED_DEFAULT_DAEMONS ?= list ("yum", "yum-updatesd", "avahi-daemon", "hplip", "pcscd", "gpm", "ipsec");
"/software/components/chkconfig/service/" = {
	stoplist = OS_UNWANTED_DEFAULT_DAEMONS;
	foreach(k;v;stoplist) {
		SELF[v]["off"]="";
		SELF[v]["startstop"] = true;
	};
	SELF;
};


# Local site OS configuration
variable OS_BASE_CONFIG_SITE_INCLUDE = if ( exists(OS_BASE_CONFIG_SITE) && is_defined(OS_BASE_CONFIG_SITE) ) {
                                         return(OS_BASE_CONFIG_SITE);
                                       } else {
                                         return(null);
                                       };
include { return(OS_BASE_CONFIG_SITE_INCLUDE) };


