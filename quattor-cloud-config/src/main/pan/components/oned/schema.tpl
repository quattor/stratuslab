# #
# Software subject to following license(s):
#   Apache 2 License (http://www.opensource.org/licenses/apache2.0)
#   Copyright (c) Centre National de la Recherche Scientifique
#

# #
# Current developer(s):
#   Charles LOOMIS <loomis@lal.in2p3.fr>
#

# 
# # 
# oned, 1.25-SNAPSHOT, 20120309.1102.15
#

declaration template components/oned/schema;

include {'quattor/schema'};

include {'pan/types'};

type structure_daemon = {
    'MANAGER_TIMER' ? long(1..)
    'HOST_MONITORING_INTERVAL' : long(1..) = 600
    'VM_POLLING_INTERVAL' : long(0..) = 600
    'VM_DIR' ? string
    'PORT' : type_port = 2633
    'VNC_BASE_PORT' : type_port = 5000
    'DEBUG_LEVEL' : long(0..3) = 2
    'SCRIPTS_REMOTE_DIR' : string = '/var/tmp/one'
};

type structure_db = {
    'backend' : string = 'sqlite' with match(SELF, 'sqlite|mysql')
    'server' ? string
    'user' ? string
    'passwd' ? string
    'db_name' ? string
} with {
    SELF['backend'] != 'mysql' ||
      (
        is_defined(SELF['server']) &&
        is_defined(SELF['user']) &&
        is_defined(SELF['passwd']) &&
        is_defined(SELF['db_name'])
      )
};

type structure_one_network = {
    'NETWORK_SIZE' : long(1..) = 254
    'MAC_PREFIX' : string = '02:00' with match(SELF, '[0-9a-fA-F][0-9a-fA-F]:[0-9a-fA-F][0-9a-fA-F]')
};

type structure_image_repos = {
    'IMAGE_REPOSITORY_PATH' ? string
    'DEFAULT_IMAGE_TYPE' : string = 'OS' with match(SELF, 'OS|CDROM|DATABLOCK')
    'DEFAULT_DEVICE_PREFIX' : string = 'hd' with match(SELF, 'hd|sd|xvd|vd')
};

type structure_mad = {
    'manager' : string with match(SELF, 'IM|VM|TM|HM|AUTH')
    'executable' : string
    'arguments' ? string
    'default' ? string
    'type' ? string with match(SELF, 'xen|kvm|xml')
} with {
    (SELF['manager'] == 'VM' && 
     is_defined(SELF['default']) &&
     is_defined(SELF['type']))
    ||
    (SELF['manager'] != 'VM' && 
     !is_defined(SELF['default']) &&
     !is_defined(SELF['type']))
};

type structure_hook = {
    'on' : string with match(SELF, 'CREATE|RUNNING|SHUTDOWN|STOP|DONE')
    'command' : string
    'arguments' : string
    'remote' : string = 'NO' with match(SELF, 'YES|NO')
};

type structure_one_host = {
    'enabled' : boolean = true
    'im_mad' : string = 'im_kvm'
    'tm_mad' : string = 'tm_stratuslab' 
    'vm_mad' : string = 'vmm_kvm'
};

type structure_one_vnet = {
    'private' : string
    'local' : string
    'public' : string
};

type structure_component_oned = {
    include structure_component
    'oned_config' : string = '/etc/one/oned.conf'
    'daemon' : structure_daemon = nlist()
    'db' : structure_db = nlist()
    'network' : structure_one_network = nlist()
    'image_repos' : structure_image_repos = nlist()
    'mads' : structure_mad{}
    'hooks' : structure_hook{}
    'hosts' : structure_one_host{}
    'vnets' : structure_one_vnet
};

bind '/software/components/oned' = structure_component_oned;
