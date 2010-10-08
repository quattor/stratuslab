${BUILD_INFO}
${LEGAL}

unique template ganglia/service/frontend;

include { 'ganglia/rpms/frontend' };
include { 'ganglia/service/gmond' };
include { 'ganglia/service/gmetad' };
