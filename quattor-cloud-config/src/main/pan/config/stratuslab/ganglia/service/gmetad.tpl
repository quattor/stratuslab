${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/ganglia/service/gmetad;

include { 'components/chkconfig/config' };

"/software/components/chkconfig/service/gmetad/on" = "";
"/software/components/chkconfig/service/gmetad/startstop" = true;


