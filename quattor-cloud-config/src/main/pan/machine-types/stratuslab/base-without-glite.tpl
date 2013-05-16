unique template machine-types/stratuslab/base-without-glite;

# Include static information and derived global variables.
#variable SITE_DB_TEMPLATE ?= if_exists('pro_site_databases');
variable SITE_DB_TEMPLATE ?= 'site/databases';
include { SITE_DB_TEMPLATE };
#variable SITE_GLOBAL_VARS_TEMPLATE ?= #if_exists('pro_site_global_variables');
variable SITE_GLOBAL_VARS_TEMPLATE ?= 'site/global_variables';
include { SITE_GLOBAL_VARS_TEMPLATE };

#
# define site functions
#
variable SITE_FUNCTIONS_TEMPLATE ?= if_exists('pro_site_functions');
variable SITE_FUNCTIONS_TEMPLATE ?= 'site/functions';
include { SITE_FUNCTIONS_TEMPLATE };

#
# profile_base for profile structure
#
include { 'quattor/profile_base' };

#
# NCM core components
#
include { 'components/spma/config' };
include { 'components/grub/config' };


#
# hardware
#


# Cluster specific configuration
variable CLUSTER_INFO_TEMPLATE ?= if_exists('pro_site_cluster_info');
variable CLUSTER_INFO_TEMPLATE ?= 'site/cluster_info';
include { CLUSTER_INFO_TEMPLATE };


# common site machine configuration
variable SITE_CONFIG_TEMPLATE ?= if_exists('pro_site_config');
variable SITE_CONFIG_TEMPLATE ?= 'site/config';
include { SITE_CONFIG_TEMPLATE };


# File system configuration.
# pro_site_system_filesystems is legacy name and is used if present.
# filesystem/config is new generic approach for configuring file systems : use if it is present. It requires
# a site configuration template passed in FILESYSTEM_LAYOUT_CONFIG_SITE (same name as previous template
# but not the same contents).
variable FILESYSTEM_CONFIG_SITE ?= if_exists("pro_site_system_filesystems");
variable FILESYSTEM_CONFIG_SITE ?= if_exists("filesystem/config");
variable FILESYSTEM_LAYOUT_CONFIG_SITE ?= "site/filesystems/glite";
variable FILESYSTEM_CONFIG_SITE ?= "site/filesystems/glite";


# Select OS version based on machine name
include { 'os/version' };


# variable indicating if namespaces must be used to access OS templates.
# Always true with gLite >= 3.1, defined for backward compatibility.
variable OS_TEMPLATE_NAMESPACE = true;


# Define OS related namespaces
variable OS_NS_CONFIG = 'config/';
variable OS_NS_OS = OS_NS_CONFIG + 'os/';
variable OS_NS_QUATTOR = OS_NS_CONFIG + 'quattor/';
variable OS_NS_RPMLIST = 'rpms/';
variable OS_NS_REPOSITORY = 'repository/';


#
# software packages
#
include { 'pan/functions' };

#
# Configure Bind resolver
#
variable SITE_NAMED_CONFIG_TEMPLATE ?= if_exists('pro_site_named_config');
variable SITE_NAMED_CONFIG_TEMPLATE ?= 'site/named';
include { SITE_NAMED_CONFIG_TEMPLATE };


#
# Include OS version dependent RPMs
#
include { "config/stratuslab/base" };


#
# Quattor client software
#
include { 'quattor/client/config' };


# Configure filesystem layout.
# Must be done after NFS initialisation as it may tweak some mount points.
include { return(FILESYSTEM_CONFIG_SITE) };


#
# Site Monitoring
#
variable MONITORING_CONFIG_SITE ?= 'site/monitoring/config';
include { if_exists(MONITORING_CONFIG_SITE) };


#
# AII component must be included after much of the other setup.
#
include { OS_NS_QUATTOR + 'aii' };


#
# Add local users if some configured
#
variable USER_CONFIG_INCLUDE = if ( exists(USER_CONFIG_SITE) && is_defined(USER_CONFIG_SITE) ) {
                                 return('users/config');
                               } else {
                                 return(null);
                               };
include { USER_CONFIG_INCLUDE };

include { 'components/symlink/config' };

"/software/components/symlink/links"=append(
  nlist( "name", "/.fakelink",
         "target","/.faketarget",
         "replace",  nlist("all","yes","link", "yes")));

# Default repository configuration template
variable PKG_REPOSITORY_CONFIG ?= 'repository/config';

variable PAKITI_ENABLED ?= false;

include {
  if ( PAKITI_ENABLED ) {
    'features/pakiti/config';
  } else {
    null;
  };
};
