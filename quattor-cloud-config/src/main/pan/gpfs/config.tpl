unique template gpfs/config;

include { 'gpfs/rpms/config' };

'/software/repositories'=append(create('repository/lal/gpfs'));
