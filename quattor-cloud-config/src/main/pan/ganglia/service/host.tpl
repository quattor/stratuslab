${BUILD_INFO}
${LEGAL}

unique template ganglia/service/host;

include { 'ganglia/rpms/host' };
include { 'ganglia/service/gmond' };
