# ----------------------------------------------------------------------
# filename      pat.tpl
# description   port address translations for OpenNebula
# ----------------------------------------------------------------------


unique template one/service/pat;

include { 'one/rpms/pat' };

# --- variables definition ---------------------------------------------

variable ONE_HOOK_PAT ?= 'pathook.rb';
variable ONE_HOOK_PAT_MINPORT ?= '20000';
variable ONE_HOOK_PAT_MAXPORT ?= '30000';
variable ONE_HOOK_PAT_RPORTS ?= list(22, 80);

# --- sudo configuration -----------------------------------------------

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


# --- one configuration ------------------------------------------------

variable ONE_HOOK_PAT_CONTENT ?= file_contents('one/hooks/pathook.rb');

include { 'components/filecopy/config' };

'/software/components/filecopy/services' = npush(
    escape(ONE_HOOKS_DIR + ONE_HOOK_PAT), nlist(
        'config', ONE_HOOK_PAT_CONTENT,
        'owner', 'root',
        'perms', '0755',
        'restart', '/sbin/service ' + ONE_SERVICE + ' restart',
    ),
);

include { 'components/oned/config' };

variable PATHOOK_RPORTS = {
    content = '';
    foreach(k; v; ONE_HOOK_PAT_RPORTS) {
        content = content + to_string(v) + ',';
    };
    content;
};
variable ONE_HOOK_PAT_ARGS_ADD = {
    args = "add -i '$VMID' -r '$NIC[IP, Network=\\"local\\"]'";
    args = args + ' -p ' + PATHOOK_RPORTS;
    args = args + ' -n ' + ONE_HOOK_PAT_MINPORT + ':' + ONE_HOOK_PAT_MAXPORT ;
    args = args + ' -l ' + DB_IP[escape(FULL_HOSTNAME)];
};
variable ONE_HOOK_PAT_ARGS_DEL = {
    args = "del -i '$VMID' -r '$NIC[IP, Network=\\"local\\"]'";
    args = args + ' -l ' + DB_IP[escape(FULL_HOSTNAME)];
};

'/software/components/oned/hooks' = npush(
    'AddPortTranslation', nlist(
        'on', 'RUNNING',
        'command', ONE_HOOK_PAT,
        'arguments', ONE_HOOK_PAT_ARGS_ADD,
    ),
    'DelPortTranslation', nlist(
        'on', 'DONE',
        'command', ONE_HOOK_PAT,
        'arguments', ONE_HOOK_PAT_ARGS_DEL,
    ),
);

