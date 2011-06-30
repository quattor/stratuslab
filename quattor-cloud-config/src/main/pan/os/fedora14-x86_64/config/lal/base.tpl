############################################################
#
# template pro_os_lal_base
#
# Define base configuration of any type of LAL (non grid) servers.
# Can be included several times.
#
# RESPONSIBLE: Michel Jouvin <jouvin@lal.in2p3.fr>
#
############################################################

template config/lal/base;


variable OS_BASE_CONFIG_SITE ?= null;

variable KERNEL_VARIANT ?= "";

# Warning !!
# Disable SElinux
# Warning !!

include { 'config/os/selinux' };

#
# Kernel version and CPU architecture
#
include { OS_NS_OS + 'kernel_version_arch' };
"/system/kernel/version" = KERNEL_VERSION;


#
# Predefined groups.
#
include { 'rpms/core' };
include { 'rpms/base' };
include { 'rpms/print_client' };
include { 'rpms/x11' };
include { 'rpms/dial_up' };
include { 'rpms/console_internet' };
include { 'rpms/graphics' };
#include { 'rpms/editors' };
include { 'rpms/emacs' };
include { 'rpms/development' };
#include { 'rpms/development_tools' };
include { 'rpms/mysql_client' };
include { 'rpms/postgresql_client' };     # Postgresql client


# Remove conflicting useless RPMs.
#
"/software/packages"=pkg_del("yum-conf-5x");  # Conflict with yum-conf
"/software/packages"=pkg_del("sysreport");    # Conflict with sos
"/software/packages"=pkg_del("java-1.4.2-gcj-compat");    # Add requirements on other packages
"/software/packages"=pkg_del("antlr");  # Requires java-gcj-compat
"/software/packages"=pkg_del("gjdoc");  # Requires java-gcj-compat
"/software/packages"=pkg_del("postgresql-jdbc");  # Requires java-gcj-compat


"/software/packages"=pkg_repl('sl-release','6.0-6.0.1','x86_64');

# OS errata and site specific updates
include { 'config/os/updates' };


# Configure Java according to gLite/OS version
include { 'config/os/java' };

# Start sshd 
include { 'components/chkconfig/config' };
#"/software/components/chkconfig/service/sshd/on" = "";
"/software/components/chkconfig/service/nscd/startstop" = true;


# Stop nscd (bug preventing correct operation if NIS enabled)
include { 'components/chkconfig/config' };
"/software/components/chkconfig/service/nscd/off" = "";
"/software/components/chkconfig/service/nscd/startstop" = true;


# Disable yum
"/software/components/chkconfig/service/yum/off" = "";
"/software/components/chkconfig/service/yum/startstop" = true;

# Local site OS configuration
variable OS_BASE_CONFIG_SITE_INCLUDE = if ( exists(OS_BASE_CONFIG_SITE) && is_defined(OS_BASE_CONFIG_SITE) ) {
                                         return(OS_BASE_CONFIG_SITE);
                                       } else {
                                         return(null);
                                       };
include { return(OS_BASE_CONFIG_SITE_INCLUDE) };
