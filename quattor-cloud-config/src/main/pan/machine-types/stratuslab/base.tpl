unique template machine-types/stratuslab/base;

variable NEW_NETWORK_CONF ?= true;

# StratusLab machine types are based on the so-called nfs machine types
# but not NFS service is actually configured at this point
include { 'machine-types/nfs' };

# Default package repository for StratusLab components
include { 'repository/config/stratuslab' };

