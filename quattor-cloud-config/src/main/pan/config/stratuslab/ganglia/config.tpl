${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/ganglia/config;

include {
 if  (DB_IP[escape(FULL_HOSTNAME)] == GANGLIA_MASTER) {
	"config/stratuslab/ganglia/service/frontend";
	} else {
	"config/stratuslab/ganglia/service/host";
 };
};
