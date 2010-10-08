${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/ganglia/service/host;

include { 'config/stratuslab/ganglia/rpms/host' };
include { 'config/stratuslab/ganglia/service/gmond' };
