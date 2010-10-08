${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/ganglia/service/frontend;

include { 'config/stratuslab/ganglia/rpms/frontend' };
include { 'config/stratuslab/ganglia/service/gmond' };
include { 'config/stratuslab/ganglia/service/gmetad' };
