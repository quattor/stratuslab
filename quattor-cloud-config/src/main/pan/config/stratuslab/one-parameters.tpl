${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/one-parameters;

#
# Full hostname of NFS server, usually OpenNebula front-end.
#
variable ONE_NFS_SERVER = 'grid277.lal.in2p3.fr';

#
# An NFS wildcard that includes all of the OpenNebula nodes.
#
variable ONE_NFS_WILDCARD = '134.158.73.0/24';

#
# Monitoring internal in seconds.  Increase this value for
# a production system.
#
variable ONE_MONITOR_INTERVAL = 30;

#
# VM polling interval in seconds.  Increase this value for
# a production system.
#
variable ONE_POLLING_INTERVAL = 30;
