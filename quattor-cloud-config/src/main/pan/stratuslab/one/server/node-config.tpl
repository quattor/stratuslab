unique template stratuslab/one/server/node-config;

variable STRATUSLAB_NODE_LIST ?= error('STRATUSLAB_NODE_LIST must be defined');

#
# Configure OpenNebula daemon.
#
include { 'components/oned/config' };

'/software/components/oned/hosts'= {
    if (is_list(STRATUSLAB_NODE_LIST)) {
        ok = first(STRATUSLAB_NODE_LIST, idx, node);
        while (ok) {
            SELF[node] = nlist('enabled', true);
            ok = next(STRATUSLAB_NODE_LIST, idx, node);
        };
    } else if (is_nlist(STRATUSLAB_NODE_LIST)) {
        foreach(node; params; STRATUSLAB_NODE_LIST) {
            if (is_nlist(params)) {
                SELF[node] = params;
            } else if (is_string(params) && params == 'DEFAULT') {
                SELF[node] = nlist('enabled', true);
            };
        };
    };
    SELF;
};
