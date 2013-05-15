unique template repository/config/stratuslab;

@{
desc = name of the template describing package repository where StratusLab components can be loaded from
values = list of template name, including namespace after repository/ (string)
default = list('stratuslab')
required = no
}
include { 'quattor/functions/repository' };

variable STRATUSLAB_PACKAGE_REPOSITORIES ?= list('stratuslab');

# Add StratusLab repository
'/software/repositories' = {
  if ( is_list(STRATUSLAB_PACKAGE_REPOSITORIES) ) {
    debug('Adding repositories for StratusLab components ('+to_string(STRATUSLAB_PACKAGE_REPOSITORIES)+')');
    add_repositories(STRATUSLAB_PACKAGE_REPOSITORIES);
  } else if ( is_undefined(STRATUSLAB_PACKAGE_REPOSITORIES) ) {
    debug('No specific repositories defined for StratusLab components');
    SELF;
  } else {
    error('STRATUSLAB_PACKAGE_REPOSITORIES must be a list of string');
  };
};


