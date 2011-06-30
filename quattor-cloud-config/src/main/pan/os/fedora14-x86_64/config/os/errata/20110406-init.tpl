unique template config/os/errata/20110406-init;

variable OS_KERNEL_VERSION_ERRATA ?= nlist(
  'sl600', '2.6.32-71.18.2.el6',
);

# Because JAVA is updated, define a new DEFAULT version to be configured
variable JAVA_JDK_DEFAULT_VERSION ?= '1.6.0_24';
