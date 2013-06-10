unique template stratuslab/one/server/node-config;

variable STRATUSLAB_NODE_LIST ?= error('STRATUSLAB_NODE_LIST must be defined');

#
# Configure OpenNebula daemon.
#
include { 'components/oned/config' };

'/software/components/oned/hosts'= {
  ok = first(STRATUSLAB_NODE_LIST, k, v);
  while (ok) {
    SELF[v]=nlist('enabled',true);
    ok = next(STRATUSLAB_NODE_LIST, k, v);
  };
  SELF;
};
