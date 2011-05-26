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

unique template one/service/pxe;


# -----------------------------------------------------------------------------


'/software/components/oned/hooks' = npush( 'pxe-create',
	nlist('on','CREATE',
	      'command','/var/lib/one/hooks/pxe-create.sh',
	      'arguments','$VMID $NIC[IP] $OS[BOOT] $CFGFILEURL $KERNELTGZURL',
	      'remote','NO')
);
'/software/components/oned/hooks' = npush( 'pxe-delete',
	nlist('on','DONE',
	      'command','/var/lib/one/hooks/pxe-delete.sh',
	      'arguments','$VMID $NIC[IP] $OS[BOOT]',
	      'remote','NO')
);


# -----------------------------------------------------------------------------


include { 'components/dirperm/config' };
"/software/components/dirperm/paths" = append(
	nlist("path","/var/lib/one/hooks",
	      "owner","oneadmin:cloud",
	      "perm","0755",
	      "type","d")
	);


include { 'components/filecopy/config' };

variable PXE_CREATE = <<EOF;
#!/bin/bash


# This hook is used to handle the creation of a net boot (pxe) configuration
# file when a virtual machine that must boot from network is created (CREATE
# state).


# First step, initialisation of some variables.

# Setting some variables from the commande line arguments.
        VMID=$1
          IP=$2
        BOOT=$3
  CFGFILEURL=$4
KERNELTGZURL=$5

# Converting the IP address in an hexadecimal form.
    IP_HEXA=`printf '%02X' ${2//./ }`

# Setting the state viariable of the VM i.e. CREATE.
STATE=CREATE

# Setting the TFTP variables.
TFTPDIRBASE=/tftpboot
TFTPDIRONE=$TFTPDIRBASE/one
TFTPDIRCONF=$TFTPDIRONE/$VMID
TFTPFILECONF=$TFTPDIRCONF/source.cfg
TFTPDIRPXE=$TFTPDIRONE/pxelinux.cfg
TFTPFILEMENU=$TFTPDIRPXE/$VMID.cfg
TFTPLINKMENU=$TFTPDIRPXE/$IP_HEXA

# Setting the log variables.
# TODO: maybe we can use the VM log i.e. /var/log/one/$VMID.log
LOGDIRBASE=/var/log
LOGDIRONE=$LOGDIRBASE/one
LOGDIRHOOKS=$LOGDIRONE/hooks
LOGDIRPXE=$LOGDIRHOOKS/pxe
LOGFILE=$LOGDIRPXE/$VMID.log


#Check the validity of the variable

#TODO or not: Check the number of argument provides to the commande line
#if [ $n !-eq 3 ]
#then
#{
#  echo a > /var/log/one/hooks/test
#}
#else
#{
#  echo b > /var/log/one/hooks/test
#}
#fi

#TODO: test if the TFTP directory is available.

#TODO: Add a procedure to initialise the creation of the log file and if the
# initialisation failled we can set LOGFILE=/dev/null.

#Print some information into the log file (for debugging :-).
echo "DATE         = "`date`                                        >> $LOGFILE
echo "VMID         = "$VMID                                         >> $LOGFILE
echo "STATE        = "$STATE                                        >> $LOGFILE
echo "IP           = "$IP                                           >> $LOGFILE
echo "IP_HEXA      = "$IP_HEXA                                      >> $LOGFILE
echo "BOOT         = "$BOOT                                         >> $LOGFILE


#Check if we are in pxe mode

#Check the third argument OS[BOOT] which indicate the booting methode of the VM.
if [ "$BOOT" = "network" ]
then
{
  #If booting from the network then continue.
  #echo \#Booting from network.                                      >> $LOGFILE
  :
}
else
{
  #If not booting from network then aborting the hook.
  echo "#Not booting from network, abandon ship!"                   >> $LOGFILE
  echo                                                              >> $LOGFILE
  exit 0
}
fi


#Create the net boot (pxe) configuration.

#Create the directory of the kernel/initrd.
mkdir $TFTPDIRCONF
echo "TFTPDIRCONF  = "$TFTPDIRCONF                                  >> $LOGFILE

#Download and untar the kernel archive.
wget -O - $KERNELTGZURL  |  tar -xzC $TFTPDIRCONF
echo "KERNELTGZURL = "$KERNELTGZURL                                 >> $LOGFILE

#Download the configuration file
wget -O $TFTPFILECONF $CFGFILEURL
echo "CFGFILEURL   = "$CFGFILEURL                                   >> $LOGFILE
echo "TFTPFILECONF = "$TFTPFILECONF                                 >> $LOGFILE

#Create the pxe boot menu file of the VM.
source $TFTPFILECONF                                                >> $LOGFILE
echo "DEFAULT "$LABEL                         >> $TFTPFILEMENU
echo "LABEL "$LABEL                           >> $TFTPFILEMENU
echo "    KERNEL "$VMID/vmlinuz               >> $TFTPFILEMENU
echo "    INITRD "$VMID/initrd.img            >> $TFTPFILEMENU
echo "    APPEND "$APPEND                     >> $TFTPFILEMENU
echo "TFTPFILEMENU = "$TFTPFILEMENU                                 >> $LOGFILE

#Create the link to the pxe boot menu file.
ln -s $VMID.cfg $TFTPLINKMENU
echo "TFTPLINKMENU = "$TFTPLINKMENU                                 >> $LOGFILE



echo                                                                >> $LOGFILE


exit 0
EOF

"/software/components/filecopy/services" = npush(
	escape("/var/lib/one/hooks/pxe-create.sh"),
	nlist("config",PXE_CREATE,
	      "owner","oneadmin",
	      "group","cloud",
	      "perms","0755")
	);


include { 'components/filecopy/config' };

variable PXE_DELETE = <<EOF;
#!/bin/bash


# This hook is used to handle the deletion of a net boot (pxe) configuration
# file when a virtual machine that must boot from network is deleted (DONE
# state).


# First step, initialisation of some variables.

# Setting some variables from the commande line arguments.
        VMID=$1
          IP=$2
        BOOT=$3
#  CFGFILEURL=$4
#KERNELTGZURL=$5

# Converting the IP address in an hexadecimal form.
    IP_HEXA=`printf '%02X' ${2//./ }`

# Setting the state viariable of the VM i.e. DONE.
STATE=DONE

# Setting the TFTP variables.
TFTPDIRBASE=/tftpboot
TFTPDIRONE=$TFTPDIRBASE/one
TFTPDIRCONF=$TFTPDIRONE/$VMID
TFTPFILECONF=$TFTPDIRCONF/source.cfg
TFTPDIRPXE=$TFTPDIRONE/pxelinux.cfg
TFTPFILEMENU=$TFTPDIRPXE/$VMID.cfg
TFTPLINKMENU=$TFTPDIRPXE/$IP_HEXA

# Setting the log variables.
# TODO: maybe we can use the VM log i.e. /var/log/one/$VMID.log
LOGDIRBASE=/var/log
LOGDIRONE=$LOGDIRBASE/one
LOGDIRHOOKS=$LOGDIRONE/hooks
LOGDIRPXE=$LOGDIRHOOKS/pxe
LOGFILE=$LOGDIRPXE/$VMID.log


#Check the validity of the variable

#TODO or not: Check the number of argument provides to the commande line
#if [ $n !-eq 3 ]
#then
#{
#  echo a > /var/log/one/hooks/test
#}
#else
#{
#  echo b > /var/log/one/hooks/test
#}
#fi

#TODO: test if the TFTP directory is available.

#TODO: Add a procedure to initialise the creation of the log file and if the
# initialisation failled we can set LOGFILE=/dev/null.

#Print some information into the log file (for debugging :-).
echo "DATE         = "`date`                                        >> $LOGFILE
echo "VMID         = "$VMID                                         >> $LOGFILE
echo "STATE        = "$STATE                                        >> $LOGFILE
echo "IP           = "$IP                                           >> $LOGFILE
echo "IP_HEXA      = "$IP_HEXA                                      >> $LOGFILE
echo "BOOT         = "$BOOT                                         >> $LOGFILE


#Check if we are in pxe mode

#Check the third argument OS[BOOT] which indicate the booting methode of the VM.
if [ "$BOOT" = "network" ]
then
{
  #If booting from the network then continue.
  #echo \#Booting from network.                                      >> $LOGFILE
  :
}
else
{
  #If not booting from network then aborting the hook.
  echo "#Not booting from network, abandon ship!"                   >> $LOGFILE
  echo                                                              >> $LOGFILE
  exit 0
}
fi


#Delete the net boot (pxe) configuration.

#Delete the directory of the kernel/initrd.
rm -rf $TFTPDIRCONF
echo "TFTPDIRCONF  = "$TFTPDIRCONF                                  >> $LOGFILE










#Delete the pxe boot menu file of the VM.
rm -f $TFTPFILEMENU

echo "TFTPFILEMENU = "$TFTPFILEMENU                                 >> $LOGFILE

#Delete the link to the pxe boot menu file.
rm -f $TFTPLINKMENU
echo "TFTPLINKMENU = "$TFTPLINKMENU                                 >> $LOGFILE
echo "#Removing the link to the pxe boot menu file"                 >> $LOGFILE


echo                                                                >> $LOGFILE


exit 0
EOF

"/software/components/filecopy/services" = npush(
	escape("/var/lib/one/hooks/pxe-delete.sh"),
	nlist("config",PXE_DELETE,
	      "owner","oneadmin",
	      "group","cloud",
	      "perms","0755")
	);


# ------------------------------------------------------------------------


include { 'components/dirperm/config' };
"/software/components/dirperm/paths" = append(
	nlist("path","/var/log/one/hooks",
	      "owner","oneadmin:cloud",
	      "perm","0755",
	      "type","d")
	);

include { 'components/dirperm/config' };
"/software/components/dirperm/paths" = append(
	nlist("path","/var/log/one/hooks/pxe",
	      "owner","oneadmin:cloud",
	      "perm","0755",
	      "type","d")
	);


# ------------------------------------------------------------------------


include { 'components/dirperm/config' };
"/software/components/dirperm/paths" = append(
	nlist("path","/tftpboot/one",
	      "owner","oneadmin:cloud",
	      "perm","0755",
	      "type","d")
	);

include { 'components/dirperm/config' };
"/software/components/dirperm/paths" = append(
	nlist("path","/tftpboot/one/pxelinux.cfg",
	      "owner","oneadmin:cloud",
	      "perm","0755",
	      "type","d")
	);

include { 'components/download/config' };
'/software/components/download/active' = true;
'/software/components/download/dispatch' = true;
'/software/components/download/files' = npush(
	escape("/tftpboot/one/pxelinux.0"),
	nlist("href","http://quattorsrv.lal.in2p3.fr/pxelinux.0",
	      "owner","oneadmin",
	      "group","cloud",
	      "perm","0644")
);












