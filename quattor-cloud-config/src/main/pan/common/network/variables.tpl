unique template common/network/variables;

include { 'stratuslab/default/parameters' };

variable STRATUSLAB_NETWORK_BRIDGE_INTERFACE  ?= 'br0';
variable STRATUSLAB_NETWORK_INTERFACE         ?= boot_nic();
