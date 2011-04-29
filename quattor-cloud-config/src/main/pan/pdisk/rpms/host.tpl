unique template pdisk/rpms/host;

variable PDISK_VERSION ?= '0.0.1-0.20110419.151046';

'/software/packages'=pkg_repl('pdisk-host', PDISK_VERSION, 'noarch');
