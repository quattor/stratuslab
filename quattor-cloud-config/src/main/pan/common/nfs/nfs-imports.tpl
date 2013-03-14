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

#
# Import the image repository, VM state area, and oneadmin home.
# Use autofs to do this to avoid mount problems at machine boot.
#

#
# Build indirect map for NFS imports.
#
include { 'components/autofs/config' };

variable STRATUSLAB_NFS_MOUNT_POINT = '/stratuslab_mnt';

variable ONE_NFS_SERVER_VAR ?= ONE_NFS_SERVER;
variable ONE_NFS_SERVER_HOME ?= ONE_NFS_SERVER;

variable ONE_NFS_SERVER_VARDIR ?= '/var/lib/one';
variable ONE_NFS_SERVER_HOMEDIR ?= '/home/oneadmin';


'/software/components/autofs/maps/stratuslab/mapname' = '/etc/auto.stratuslab';
'/software/components/autofs/maps/stratuslab/type' = 'file';
'/software/components/autofs/maps/stratuslab/options' = '-rw,intr,noatime,hard';
'/software/components/autofs/maps/stratuslab/mountpoint' = STRATUSLAB_NFS_MOUNT_POINT;
'/software/components/autofs/maps/stratuslab/enabled' = true;
'/software/components/autofs/maps/stratuslab/preserve' = false;

'/software/components/autofs/maps/stratuslab/entries/onevar' =
  nlist('location', ONE_NFS_SERVER_VAR + ':' + ONE_NFS_SERVER_VARDIR,
        'options', '');
  
'/software/components/autofs/maps/stratuslab/entries/oneadmin' = 
   nlist('location', ONE_NFS_SERVER_HOME + ':' + ONE_NFS_SERVER_HOMEDIR,
        'options', '');

# Enable autofs as a service.
include { 'components/chkconfig/config' };
'/software/components/chkconfig/service/autofs/on' = '';
'/software/components/chkconfig/service/autofs/startstop' = true;

# Ensure that accounts is run before autofs for correct ownership.
include { 'components/accounts/config' };
'/software/components/accounts/dependencies/pre' = append('autofs');    

# Define symlinks to actual mount point
include { 'components/symlink/config' };

'/software/components/symlink/links' = if ( FULL_HOSTNAME != ONE_NFS_SERVER_VAR) {
	append(
  	nlist('name', '/var/lib/one',
              'target', STRATUSLAB_NFS_MOUNT_POINT + '/onevar',
              'exists', false,
              'replace', nlist('all','yes'))
	);
	} else {
		SELF;
};

'/software/components/symlink/links' =  if ( FULL_HOSTNAME != ONE_NFS_SERVER_HOME) {
	append(
  	nlist('name', '/home/oneadmin',
              'target', STRATUSLAB_NFS_MOUNT_POINT + '/oneadmin',
              'exists', false,
              'replace', nlist('all','yes'))
	); } else {
		SELF;
};

include { 'components/filecopy/config' };

'/software/components/filecopy/services/{/etc/idmapd.conf}'= {
  nlist('config',format(file_contents('common/nfs/idmapd.conf'),
                  SITE_DOMAIN),
  'owner','root:root',
  'perms','0644',)
};
