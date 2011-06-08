# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

declaration template components/claudia/schema;

include { 'quattor/schema' };

type network_mac_sm_claudia_config = {
	'MacEnabled'     : boolean = false
	'NetworkMacList' : string
};

type network_range_sm_claudia_config = {
	'Network' ? string
	'IP'      : string
	'Netmask' : string
	'Gateway' : string
	'DNS'     : string
	'Public'  : boolean
};

type wasup_sm_claudia_config = {
   'WASUPActive'   : boolean = true
   'WASUPHost'     : string  = 'localhost'
   'WASUPPort'     : long    = 7001
   'WASUPPath'     : string  = '/wasup'
   'WASUPLogin'    : string
   'WASUPPassword' : string

   'wasup.customer'   : string = 'vdc'
   'wasup.service'    : string = 'service'
   'wasup.vee'        : string = 'vee'
   'wasup.veereplica' : string = 'veeReplica'
   'wasup.network'    : string = 'net'
   'wasup.hw'         : string = 'hwItem'
};

type veem_sm_claudia_config = {
   'VEEMHost' : string = 'localhost'
   'VEEMPort' : long   = 8182
   'VEEMPath' : string = '/'
   'ExtendedOCCI' : boolean = false
};

type image_sm_claudia_config = {
   'ImagesServerHost' : string = 'localhost'
   'ImagesServerPort' : long   = 5555
   'ImagesServerPath' : string = '/'
};

type smi_sm_claudia_config = {
   'SMIHost' : string = 'localhost'
   'SMIPort' : long   = 8181
};

type rest_sm_claudia_config = {
   'RestListenerHost' : string = 'localhost'
   'RestListenerPort' : long   = 1114
};

type java_sm_claudia_config = {
   'java.naming.factory.initial' : string = 'org.apache.activemq.jndi.ActiveMQInitialContextFactory'
   'java.naming.provider.url'    : string = 'tcp://localhost:61616'
};

type sm_claudia_config = {
   'config_file' : string = '/opt/claudia/conf/sm.properties'
   'java'        : java_sm_claudia_config  = nlist()
   'rest'        : rest_sm_claudia_config  = nlist()
   'SMI'         : smi_sm_claudia_config   = nlist() 
   'ImageServer' : image_sm_claudia_config = nlist()
   'VEEM'        : veem_sm_claudia_config  = nlist()

   'UndeployOnServerStop' : boolean = false
   'ActivateAcd'          : boolean = false

   'MonitoringAddress'    : string = '229.229.0.1'

   'WASUP' : wasup_sm_claudia_config = nlist()

   'SiteRoot' : string

   'NetworkRanges' : network_range_sm_claudia_config[] = list()
   'NetworkMac'    : network_mac_sm_claudia_config = nlist()
   'StaticIpList'  ? string

   'DomainName'   : string = 'LocalDomain'
   'OVFEnvEntity' : boolean = true
};

type report_claudia_config = {
    'config_file' : string = '/opt/claudia/conf/reportClient.properties'

    'TServer.url' : string = 'http://127.0.0.1:8182'

    'vmDiscoverDelay' : long = 180
    'monitoringDelay' : long = 30

    'vmMonName'  ? string

    'MonitorName' ? string

    'restPath'       : string = '/vmi'
    'restServerPort' : long = 1114
    'restServerHost' : string = 'localhost'

    'rootReportDirectory' : string = './reports'

    'SiteRoot' : string 
};

type tcloud_claudia_config = {
     'config_file' : string = '/opt/claudia/conf/tcloud.properties'

     'com.telefonica.claudia.smi.drivers.deployment'   : string = 'com.telefonica.claudia.smi.deployment.SMDeploymentDriver'
     'com.telefonica.claudia.smi.drivers.provisioning' : string = 'com.telefonica.claudia.smi.provisioning.ONEProvisioningDriver'
     'com.telefonica.claudia.smi.drivers.monitoring'   : string ='com.telefonica.claudia.smi.monitoring.WasupMonitoringDriver'

     'com.telefonica.claudia.server.host'        : string = 'localhost'
     'com.telefonica.claudia.server.port'        : long = 8182
     'com.telefonica.claudia.customization.port' : long = 18888

     'java.naming.factory.initial' : string = 'org.apache.activemq.jndi.ActiveMQInitialContextFactory'
     'java.naming.provider.url'    : string = 'tcp://localhost:61616'

     'oneUrl'             : string = 'http://localhost:2633/RPC2'
     'oneUser'            : string = 'OCCIServer'
     'onePassword'        : string
     'oneEnvironmentPath' : string = '/home/claudia/tcloud/repository'
     'oneKernel'          : string = '/boot/vmlinuz-2.6.26-2-xen-amd64'
     'oneInitrd'          : string = '/boot/initrd.img-2.6.26-2-xen-amd64'
     'oneNetworkBridge'   : string = 'br0'
     'oneSshKey'          : string

     'vmwareUrl'      : string = 'https://10.95.129.1/sdk'
     'vmwareUser'     : string = 'root'
     'vmwarePassword' ? string

     'monitoring.wasup.uri'      : string = 'http://localhost:7001/wasup'
     'monitoring.wasup.login'    : string = 'rps'
     'monitoring.wasup.password' ? string
};

type claudia_component = {
    include structure_component
    'sm-config'           : sm_claudia_config     = nlist()
    'reportClient-config' : report_claudia_config = nlist()
    'tcloud-config'       : tcloud_claudia_config = nlist()
};

bind '/software/components/claudia' = claudia_component;
