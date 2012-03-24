unique template common/iptables/base;

variable STRATUSLAB_IPTABLES_ENABLE ?= true;

include { 'components/iptables/config' };

prefix '/software/components/iptables/filter';

# Use a secure policy by default for inbound connections. That's why following
# filter rules should not target reject rules.
'preamble/input' = if (STRATUSLAB_IPTABLES_ENABLE ) {
 'DROP [0:0]';
} else {
 'ACCEPT [0:0]';
};
'preamble/forward' = if (STRATUSLAB_IPTABLES_ENABLE ) {
 'DROP [0:0]';
} else {
 'ACCEPT [0:0]';
};
'preamble/output' = 'ACCEPT [0:0]';

'rules' = {
# Common rules
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'match', 'state',
    'state', 'RELATED,ESTABLISHED',
    'target', 'ACCEPT',
  ));
# SSH port
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'protocol', 'tcp',
    'match', 'tcp',
    'dst_port', '22',
    'target', 'ACCEPT',
  ));
# Quattor port
  append(nlist(
    'command', '-A',
    'chain', 'INPUT',
    'protocol', 'udp',
    'match', 'udp',
    'dst_port', '7777',
    'target', 'ACCEPT',
  ));
};

'epilogue' = 'COMMIT';