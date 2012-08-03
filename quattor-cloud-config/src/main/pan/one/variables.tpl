unique template one/variables;

include { 'stratuslab/default/parameters' };

variable STRATUSLAB_ONE_HOST ?= '';
variable STRATUSLAB_ONE_USERNAME ?= ONE_USER;
variable STRATUSLAB_ONE_PASSWORD ?= 'STRATUSLAB_ONE_PASSWORD should_be_modify_after_installation';
variable STRATUSLAB_ONE_PORT ?= '2633';
variable STRATUSLAB_ONE_IPV6_PREFIX ?= if (STRATUSLAB_IPV6_ENABLE) {
	error('You need to have a IPV6_PREFIX');
} else {
	  '';
};
