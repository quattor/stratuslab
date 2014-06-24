unique template stratuslab/one-proxy/variables;

variable STRATUSLAB_LDAP_CONFIG ?= false;

variable STRATUSLAB_LDAP_HOST ?= '';
variable STRATUSLAB_LDAP_PORT ?= '10389';
variable STRATUSLAB_LDAP_BIND_DN ?= 'cn=jetty,ou=daemons,o=stratuslab';
variable STRATUSLAB_LDAP_BIND_PWD ?= '';
variable STRATUSLAB_LDAP_USER_BASE_DN ?= 'ou=people,o=stratuslab';
variable STRATUSLAB_LDAP_ROLE_DN ?= 'ou=groups,o=stratuslab';