unique template one/service/vmm_exec_kvm_sl6;

include { 'components/filecopy/config' };

prefix '/software/components/filecopy';

'services/{/etc/one/vmm_exec/vmm_exec_kvm_sl6.conf}'= nlist(
  'config', file_contents('one/service/vmm_exec_kvm_sl6.conf'),
  'owner', 'root:root',
  'perms', '0644',
);
