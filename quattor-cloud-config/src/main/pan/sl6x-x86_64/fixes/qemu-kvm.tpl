unique template fixes/qemu-kvm;

include { 'components/symlink/config' };

'/software/components/symlink/links' = append(
	nlist('name', '/usr/bin/qemu-kvm',
		'target', '/usr/libexec/qemu-kvm',
		'exists', false,
		'replace', nlist('all','yes')
	)
);
