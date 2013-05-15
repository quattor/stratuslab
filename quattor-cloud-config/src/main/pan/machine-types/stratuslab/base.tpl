unique template machine-types/stratuslab/base;

variable GLITE_DEPENDENCY ?= false;

# StratusLab machine types are based on the so-called nfs machine types
# but not NFS service is actually configured at this point
include { 
  if ( GLITE_DEPENDENCY) { 
    'machine-types/nfs';
  } else {
    'machine-types/stratuslab/base-without-glite';
  };
};

# Default package repository for StratusLab components
include { 'repository/config/stratuslab' };

