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
unique template stratuslab/marketplace/service/mysql;

include { 'stratuslab/marketplace/variables' };
include { 'common/mysql/server' };

include { 'components/mysql/config' };

# ------------------------------------------------------------------------
prefix '/software/components/mysql';

'servers/localhost/adminuser' = MYSQL_USER;
'servers/localhost/adminpwd' = MYSQL_PASSWORD;

'databases' = {
  SELF[STRATUSLAB_MARKETPLACE_DB_NAME]['server'] = 'localhost';
  SELF[STRATUSLAB_MARKETPLACE_DB_NAME]['initOnce'] = true;
  SELF[STRATUSLAB_MARKETPLACE_DB_NAME]['users'][escape(STRATUSLAB_MARKETPLACE_DB_USER+'@localhost')] = nlist('password', STRATUSLAB_MARKETPLACE_DB_USER_PWD,
                                                'rights', list('ALL PRIVILEGES'),
                                               );
  SELF[STRATUSLAB_MARKETPLACE_DB_NAME]['tableOptions']['short_fields']['MAX_ROWS'] = '1000000000';
  SELF[STRATUSLAB_MARKETPLACE_DB_NAME]['tableOptions']['long_fields']['MAX_ROWS'] = '55000000';
  SELF[STRATUSLAB_MARKETPLACE_DB_NAME]['tableOptions']['events']['MAX_ROWS'] = '175000000';
  SELF[STRATUSLAB_MARKETPLACE_DB_NAME]['tableOptions']['states']['MAX_ROWS'] = '9500000';
  
  SELF;
};
