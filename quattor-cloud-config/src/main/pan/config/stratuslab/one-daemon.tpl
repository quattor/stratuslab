${BUILD_INFO}
${LEGAL}

unique template config/stratuslab/one-daemon;

#
# Start the OpenNebula daemon (oned) at boot. 
#
include {'components/chkconfig/config'};
'/software/components/chkconfig/service/oned' = nlist('on', '', 'startstop', true);

#
# Configure OpenNebula daemon.
#
include { 'components/oned/config' };

#
# Monitoring delays are appropriate for small/testing systems.
# Change to longer delays for production systems.
#
'/software/components/oned/daemon/HOST_MONITORING_INTERVAL' = ONE_MONITOR_INTERVAL;
'/software/components/oned/daemon/VM_POLLING_INTERVAL' = ONE_POLLING_INTERVAL;

#
# Change the default locations of the image and VM directories.
#
'/software/components/oned/daemon/VM_DIR' = '/var/lib/one/vms';
'/software/components/oned/image_repos/IMAGE_REPOSITORY_PATH' = '/var/lib/one/images';

#
# Define all of the standard plug-ins for OpenNebula. 
# Assumes that KVM is being used on the site.
#
'/software/components/oned/mads/im_kvm' = nlist(
    'manager', 'IM',
    'executable', 'one_im_ssh',
    'arguments', 'im_kvm/im_kvm.conf'
  );

'/software/components/oned/mads/vmm_kvm' = nlist(
    'manager', 'VM',
    'executable', 'one_vmm_kvm',
    'default', 'vmm_kvm/vmm_kvm.conf',
    'type', 'kvm'
  );

'/software/components/oned/mads/tm_nfs' = nlist(
    'manager', 'TM',
    'executable', 'one_tm',
    'arguments', 'tm_nfs/tm_nfs.conf'
  );

'/software/components/oned/mads/hm' = nlist(
    'manager', 'HM',
    'executable', 'one_hm'
  );

'/software/components/oned/hooks/image' = nlist(
    'on', 'DONE',
    'command', '/usr/share/one/hooks/image.rb',
    'arguments', '$VMID'
  );
