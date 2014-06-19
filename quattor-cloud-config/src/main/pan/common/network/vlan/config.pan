unique template common/network/vlan/config;

include { 'components/modprobe/config' };

'/software/components/modprobe/modules' = push(nlist('name', '8021q'));
'/software/components/network/dependencies/pre' = push('modprobe');

