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

unique template common/nfs/nfs-imports;

include { 'common/nfs/variables' };
#
# Import the image repository, VM state area, and oneadmin home.
# Use autofs to do this to avoid mount problems at machine boot.
#

#
# Build indirect map for NFS imports.
#
include { 'components/autofs/config' };

prefix '/software/components/autofs/maps/stratuslab';
'mapname' = '/etc/auto.stratuslab';
'type' = 'file';
'options' = '-rw,intr,noatime,hard';
'mountpoint' = STRATUSLAB_NFS_MOUNT_POINT;
'enabled' = true;
'preserve' = false;

'entries' = {
if ( STRATUSLAB_NFS_VARDIR_ENABLE ) {
  SELF['onevar'] = nlist('location', format("%s:%s",STRATUSLAB_NFS_SERVER_VAR,
                                                    STRATUSLAB_NFS_SERVER_VARDIR),
                         'options', '');
  } else {
  SELF;
  };
  SELF[STRATUSLAB_UNIX_USER_ACCOUNT] = nlist('location', format("%s:%s",STRATUSLAB_NFS_SERVER_HOME,
                                                                        STRATUSLAB_NFS_SERVER_HOMEDIR),
                                             'options', '');
  SELF;
};
  

# Enable autofs as a service.
include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/autofs/on' = '';
'/software/components/chkconfig/service/autofs/startstop' = true;

# Ensure that accounts is run before autofs for correct ownership.
include { 'components/accounts/config' };
'/software/components/accounts/dependencies/pre' = append('autofs');    

# Define symlinks to actual mount point
include { 'components/symlink/config' };

'/software/components/symlink/links' = 
if ( FULL_HOSTNAME != STRATUSLAB_NFS_SERVER_VAR) {
  append(
    nlist('name',   STRATUSLAB_ONE_VARDIR,
          'target', STRATUSLAB_NFS_MOUNT_POINT + '/onevar',
          'exists', false,
          'replace', nlist('all','yes'))
  );
} else {
  SELF;
};

'/software/components/symlink/links' =  
if ( FULL_HOSTNAME != STRATUSLAB_NFS_SERVER_HOME) {
  append(
    nlist('name',   STRATUSLAB_NFS_SERVER_HOMEDIR,
          'target', STRATUSLAB_NFS_MOUNT_POINT + '/' + STRATUSLAB_UNIX_USER_ACCOUNT,
          'exists', false,
          'replace', nlist('all','yes'))
  ); 
} else {
  SELF;
};

include { 'components/filecopy/config' };

'/software/components/filecopy/services/{/etc/idmapd.conf}'= {
  nlist('config',format(file_contents('common/nfs/idmapd.conf'),
                  SITE_DOMAIN),
  'owner','root:root',
  'perms','0644',)
};
