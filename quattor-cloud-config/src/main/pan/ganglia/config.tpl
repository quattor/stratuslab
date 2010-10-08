${BUILD_INFO}
${LEGAL}

unique template ganglia/config;

include {
  if  (DB_IP[escape(FULL_HOSTNAME)] == GANGLIA_MASTER) {
    'ganglia/service/frontend';
  } else {
    'ganglia/service/host';
  };
};
