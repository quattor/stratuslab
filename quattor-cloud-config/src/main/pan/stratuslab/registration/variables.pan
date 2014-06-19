# ${BUILD_INFO}
#
# Created as part of the StratusLab project (http://stratuslab.eu)
#
# Copyright (c) 2010-2011, Centre National de la Recherche Scientifique
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
unique template stratuslab/registration/variables;

include { 'stratuslab/default/parameters' };

variable STRATUSLAB_REGISTRATION_HOST ?= '';

variable STRATUSLAB_REGISTRATION_LDAP_MANAGER_DN ?= 'cn=admin,o=cloud';
variable STRATUSLAB_REGISTRATION_LDAP_MANAGER_PWD ?= 'changeme';
variable STRATUSLAB_REGISTRATION_ADMIN_EMAIL ?= STRATUSLAB_MAIL_EMAIL;
variable STRATUSLAB_REGISTRATION_MAIL_HOST ?= STRATUSLAB_MAIL_HOST;
variable STRATUSLAB_REGISTRATION_MAIL_PORT ?= STRATUSLAB_MAIL_PORT;
variable STRATUSLAB_REGISTRATION_MAIL_USER ?= STRATUSLAB_MAIL_USER;
variable STRATUSLAB_REGISTRATION_MAIL_USER_PWD ?= STRATUSLAB_MAIL_USER_PWD;
variable STRATUSLAB_REGISTRATION_MAIL_SSL ?= STRATUSLAB_MAIL_SSL;
variable STRATUSLAB_REGISTRATION_MAIL_DEBUG ?= STRATUSLAB_MAIL_DEBUG;
