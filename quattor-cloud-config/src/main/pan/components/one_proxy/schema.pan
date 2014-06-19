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
# one_proxy, 1.26-SNAPSHOT, 20120329.1333.24
#

declaration template components/one_proxy/schema;

include { 'quattor/schema' };

type one_proxy_userdn_config = {
    'groups' : string[]
} = nlist();

type one_proxy_user_pswd = {
    'password' : string
    'groups' : string[] = list("cloud-access")
} = nlist();

type one_proxy_user_cert = {
    'groups' : string[] = list("cloud-access")
} = nlist();

type one_proxy_login_module = {
    'name' : string
    'flag' : string with match(SELF, 'required|requisite|sufficient|optional')
    'options' ? string{}
};

type one_proxy_jaas_entry = {
    'login_modules' : one_proxy_login_module[]
};

type one_proxy_config = {
    'users_by_pswd' : one_proxy_user_pswd{}
    'users_by_cert' : one_proxy_user_cert{}
    'jaas' : one_proxy_jaas_entry{}
} = nlist();

type component_one_proxy = {
    include structure_component
    'dir'    : string = '/etc/stratuslab/authn'
	 'daemon' : string[] = list('one-proxy')
    'config' : one_proxy_config
} = nlist();

bind '/software/components/one_proxy' = component_one_proxy;
