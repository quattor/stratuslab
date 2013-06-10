StratusLab Quattor Configuration
================================

Quattor configuration and configuration modules for StratusLab
services.

License
-------

Licensed under the Apache License, Version 2.0 (the "License"); you
may not use this file except in compliance with the License.  You may
obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
implied.  See the License for the specific language governing
permissions and limitations under the License.

Acknowledgements
----------------

StratusLab is co-funded by the European Community’s Seventh Framework
Programme (Capacities) Grant Agreement INFSO-RI-261552.

User Manual
-----------

1. unpack quattor-cloud-config/src/main/pan/ on your SCDB on a directory
under cfg/ ( cfg/stratuslab-version per example).
2. Define a template under your cluster named one/service/site_parameters

StratusLab quattor template provide 4 differents machine-types:
* machine-types/stratuslab/one-frontend : OpenNebula frontend
* machine-types/stratuslab/one-host : Hypervisor
* machine-types/stratuslab/marketplace : A stratuslab marketplace
* machine-types/stratuslab/registration : The registration service

To use StratusLab quattor template, you need to define some variables

To configure NFS part. NFS is needed to share oneadmin account and currently running images
* STRATUSLAB_NFS_ENABLE : Let Stratuslab quattor template configure NFS / Autofs
 [default : true]. If you want use GPFS or another Shared FS, disable it.
* STRATUSLAB_NFS_SERVER : The NFS server on your infrastructure
* STRATUSLAB_NFS_WILDCARD : List of ranged IP address that can connect to NFS server

To configure Persistent disk service, some variable must be put
* STRATUSLAB_PDISK_HOST : Your stratuslab persistent disk server
* STRATUSLAB_PDISK_SUPER_USER_PWD : The 'clear' password of persistent disk super account
* STRATUSLAB_PDISK_BACKEND_TYPE : You can choose your backend, file for shared FS (nfs, gpfs, ...) or iscsi
  for iscsi backend
* STRATUSLAB_PDISK_ISCSI_DEVICE : Only needed with iscsi backend (with lvm). This is the LVM device where 
  you will put your persistent disk device [default : /dev/vg.02]

To configure OpenNebula, you must provide a list of network OpenNebula will manage
* ONE_NETWORK
    variable ONE_NETWORK = nlist(
    'domain','example.org',
    'nameserver', list('8.8.8.8'),
    'public', nlist(
         'interface', 'br0',
         'subnet', '1.1.1.0',
         'router', '1.1.1.1',
         'netmask', '255.255.255.0',
         'vms',nlist(
                 'onevm-32',nlist('mac-address','0a:0a:86:9e:49:20','fixed-address','1.1.1.32','claudia','no'),
               ) ,
       ),
    'local',nlist(
        'interface', 'br0:privlan',
        'subnet',  '172.17.16.0',
        'router',  '172.17.16.1',
        'netmask', '255.255.255.0',
        'vms',nlist(
                'onevmp-32',nlist('mac-address','0a:0b:86:9e:49:20','fixed-address','172.17.16.32','claudia','no'),
              ),
        ),
    );

After installation, you need to modify STRATUSLAB_ONE_PASSWORD variable with the password you will find
on /home/oneadmin/.one/one_auth ( oneadmin:xxxx is xxxx )
