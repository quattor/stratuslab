unique template machine-types/stratuslab/base;

include { 'stratuslab/default/parameters' };
include { STRATUSLAB_CORE_OS_TEMPLATE };

 #
# Ganglia for the monitoring of machines and hosts
#
include {
  if (STRATUSLAB_GANGLIA_ENABLE) {
    'monitoring/ganglia/config' 
  } else {
    null; 
  }; 
};

include { 'components/symlink/config' };

"/software/components/symlink/links"=append(
  nlist( "name", "/.fakelink",
         "target","/.faketarget",
         "replace",  nlist("all","yes","link", "yes")));

# Default package repository for StratusLab components
include { 'repository/config/stratuslab' };
