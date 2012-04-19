unique template pdisk/server/sudo;

include { 'components/sudo/config' };

prefix '/software/components/sudo';

'privilege_lines' = append(nlist(
	'user','oneadmin',
	'run_as','ALL',
	'host','ALL',
	'options','NOPASSWD',
	'cmd','ALL',
	)
);
