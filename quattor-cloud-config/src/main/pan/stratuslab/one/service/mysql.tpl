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

unique template stratuslab/one/service/mysql;

include { 'common/mysql/server' };

include { 'components/mysql/config' };

# ------------------------------------------------------------------------
prefix '/software/components/mysql/servers/localhost';

'adminuser' = MYSQL_USER;
'adminpwd' = MYSQL_PASSWORD;
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
prefix '/software/components/oned/db';

'backend' = 'mysql';
'server' = MYSQL_HOST;
'user' = MYSQL_USER;
'passwd' = MYSQL_PASSWORD;
'db_name' = MYSQL_ONEDB; 
# ------------------------------------------------------------------------

# ------------------------------------------------------------------------
include { 'components/filecopy/config' };

variable CONTENTS = 
  format(file_contents('stratuslab/one/service/mysql-auth.conf'), 
         MYSQL_USER, 
         MYSQL_PASSWORD,
         MYSQL_HOST, 
         MYSQL_ONEDB, 
         ONE_CPU_QUOTA, 
         ONE_RAM_KB_QUOTA);

'/software/components/filecopy/services/{/etc/one/auth/auth.conf}' =
  nlist('config', CONTENTS,
        'restart', 'service oned restart',
        'perms', '0644');
# ------------------------------------------------------------------------




