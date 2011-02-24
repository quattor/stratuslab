# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

declaration template components/cloudauthn/schema;

include { 'quattor/schema' };

type cloudauthn_userdn_config = {
    'groups' : string[]
} = nlist();

type cloudauthn_user_pswd = {
    'password' : string
    'groups' : string[] = list("cloud-access")
};

type cloudauthn_user_cert = {
    'groups' : string[] = list("cloud-access")
};

type cloudauthn_login_module = {
    'name' : string
    'flag' : string with matches(SELF, 'required|requisite|sufficient|optional')
    'options' ? string{}
};

type cloudauthn_jaas_entry = {
    'login_modules' : cloudauthn_login_module[]
};

type cloudauthn_config = {
    'users_by_pswd' : cloudauthn_user_pswd{}
    'users_by_cert' : cloudauthn_user_cert{}
    'jaas' : cloudauthn_jaas_entry{}
} = nlist();

type cloudauthn_component = {
    include structure_component
    'config' : config_cloudauthn
};

bind '/software/components/cloudauthn' = component_cloudauthn;
