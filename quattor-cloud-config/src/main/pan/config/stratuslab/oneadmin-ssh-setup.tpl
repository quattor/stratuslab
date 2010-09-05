${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/oneadmin-ssh-setup;

#
# Use filecopy to get the oneadmin ssh keys into place.  This generates
# a new ssh key-pair (if necessary) and adds the public key to the 
# authorized key files.  
#
variable SSH_SETUP_SCRIPT = 
  'rm -f /home/oneadmin/.ssh/id_rsa* /home/oneadmin/.ssh/authorized*; ' +
  'ssh-keygen -f /home/oneadmin/.ssh/id_rsa -t rsa -N '''' -q; ' +
  'cp /home/oneadmin/.ssh/id_rsa.pub /home/oneadmin/.ssh/authorized_keys; ' + 
  'cp /home/oneadmin/.ssh/id_rsa.pub /home/oneadmin/.ssh/authorized_keys2; ' + 
  'chown -R oneadmin:cloud /home/oneadmin/.ssh';

#
# The trigger for the configuration is the ~/.ssh/config file.  Ensure that
# the strict host checking is not done so that initial connections are not
# blocked with an interactive prompt.
#  
include { 'components/filecopy/config' };
'/software/components/filecopy/services/{/home/oneadmin/.ssh/config}' = nlist(
  'config', "Host *\n    StrictHostKeyChecking no\n",
  'owner', 'oneadmin',
  'group', 'cloud',
  'perms', '0600',
  'restart', SSH_SETUP_SCRIPT,
  'backup', false,
  'forceRestart', false
);
