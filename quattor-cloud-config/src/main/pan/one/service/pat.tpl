# ----------------------------------------------------------------------
# filename      pat.tpl
# description   port address translations for OpenNebula
# ----------------------------------------------------------------------


unique template one/service/pat;

include { 'one/rpms/pat' };

# --- Variables --------------------------------------------------------

variable PATHOOK_FILENAME ?= 'pathook.rb';
variable PATCORE_FILENAME ?= 'patcore.rb';
variable PATRESTORER_FILENAME ?= 'patrestorer.rb';

variable ONE_RUBY_LIB_DIR ?= '/usr/lib/one/ruby';

# Define the ports range used on the StratusLab front-end to translate
# virtual machines ports.
variable ONE_HOOK_PAT_MINPORT ?= '20000';
variable ONE_HOOK_PAT_MAXPORT ?= '30000';

# Define the authorized ports to be translated. Only these ports can be
# translated on the StratusLab front-end.
variable ONE_HOOK_PAT_APORTS ?= list(22);

# Define the base ports to translate. These ports will be translated
# whatever the appliance manifest indicates.
variable ONE_HOOK_PAT_BPORTS ?= list(22);

# --- Functions --------------------------------------------------------

##
# function      join
# description   join a list of items
# parameters    items - list of items
#               separator - separator between items (default: ',')
# return        string
function join = {
    if( ARGC < 1 || !is_list(ARGV[0]) ) error("require at least a list at first argument");
    items = ARGV[0];
    if( ARGC > 1 ) {
        separator = ARGV[1];
    } else {
        separator = ',';
    };

    str = '';
    foreach(k; v; items) {
        str = str + separator + to_string(v);
    };
    substr(str, 1);
};

# --- Configuration ----------------------------------------------------

include { 'components/sudo/config' };

'/software/components/sudo/cmd_aliases' = {
    SELF['FIREWALL_CMDS'] = list('/sbin/iptables');
    SELF;
};

# oneadmin  ALL= NOPASSWD: FIREWALL
'/software/components/sudo/privilege_lines' = push(
    nlist(
        'user', ONE_USER,
        'run_as', 'root',
        'host', 'ALL',
        'options', 'NOPASSWD',
        'cmd', 'FIREWALL_CMDS'
    ),
);

include { 'components/filecopy/config' };

variable FILE_CONTENT = file_contents('one/pat/' + PATHOOK_FILENAME);
'/software/components/filecopy/services' = npush(
    escape(ONE_HOOKS_DIR + PATHOOK_FILENAME), nlist(
        'config', FILE_CONTENT,
        'owner', 'root',
        'perms', '0755',
        'restart', '/sbin/service ' + ONE_SERVICE + ' restart',
    ),
);

variable FILE_CONTENT = file_contents('one/pat/' + PATCORE_FILENAME);
'/software/components/filecopy/services' = npush(
    escape(ONE_RUBY_LIB_DIR + '/' + PATCORE_FILENAME), nlist(
        'config', FILE_CONTENT,
        'owner', 'root',
        'perms', '0755',
        'restart', '/sbin/service ' + ONE_SERVICE + ' restart',
    ),
);

variable FILE_CONTENT = file_contents('one/pat/' + PATRESTORER_FILENAME);
'/software/components/filecopy/services' = npush(
    escape('/usr/sbin/' + PATRESTORER_FILENAME), nlist(
        'config', FILE_CONTENT,
        'owner', 'root',
        'perms', '0755',
        'restart', '/sbin/service ' + ONE_SERVICE + ' restart',
    ),
);

include { 'components/oned/config' };

variable ONE_HOOK_PAT_ARGS_ADD = {
    args = "add '$VMID'";
    args = args + ' -a ' + join(ONE_HOOK_PAT_APORTS);
    args = args + ' -b ' + join(ONE_HOOK_PAT_BPORTS);
    args = args + ' -r ' + ONE_HOOK_PAT_MINPORT + ':' + ONE_HOOK_PAT_MAXPORT ;
    args = args + ' -v';
};
variable ONE_HOOK_PAT_ARGS_DEL = {
    args = "del '$VMID'";
    args = args + ' -a ' + join(ONE_HOOK_PAT_APORTS);
    args = args + ' -b ' + join(ONE_HOOK_PAT_BPORTS);
    args = args + ' -v';
};

'/software/components/oned/hooks' = npush(
    'AddPortTranslation', nlist(
        'on', 'RUNNING',
        'command', ONE_HOOKS_DIR + PATHOOK_FILENAME,
        'arguments', ONE_HOOK_PAT_ARGS_ADD,
    ),
    'DelPortTranslation', nlist(
        'on', 'DONE',
        'command', ONE_HOOKS_DIR + PATHOOK_FILENAME,
        'arguments', ONE_HOOK_PAT_ARGS_DEL,
    ),
);

