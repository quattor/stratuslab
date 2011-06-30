unique template config/lal/glite_ui;

#
# Add some RPMs normally part of SLC but not included in any group in SL
#

'/software/packages' = pkg_repl('perl-SOAP-Lite','0.69-1.el5.rf','noarch');
# Dependencies for perl-SOAP-Lite
'/software/packages'=pkg_repl('perl-Authen-SASL','2.10-1.el5.rf','noarch');
'/software/packages'=pkg_repl('perl-IO-Socket-SSL','1.01-1.fc6','noarch');
'/software/packages'=pkg_repl('perl-Net-Jabber','2.0-1.2.el5.rf','noarch');
'/software/packages'=pkg_repl('perl-MIME-Lite','3.01-2.2.el5.rf','noarch');
'/software/packages'=pkg_repl('perl-GSSAPI','0.23-1.el5.rf',PKG_ARCH_GLITE);
'/software/packages'=pkg_repl('perl-Net-SSLeay','1.30-4.fc6',PKG_ARCH_GLITE);
'/software/packages'=pkg_repl('perl-Net-XMPP','1.02-1.el5.rf','noarch');
'/software/packages'=pkg_repl('perl-XML-Stream','1.22-1.2.el5.rf','noarch');

'/software/packages' = pkg_repl('perl-Digest-HMAC','1.01-15','noarch');
'/software/packages' = pkg_repl('perl-Digest-SHA1','2.11-1.2.1',PKG_ARCH_DEFAULT);

# Required by edg-job-xxx commands
'/software/packages' = pkg_repl('tk','8.4.13-5.el5_1.1',PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl('tkinter','2.4.3-27.el5',PKG_ARCH_DEFAULT);
'/software/packages' = pkg_repl('tix','8.4.0-11.fc6',PKG_ARCH_DEFAULT);

# May be useful
'/software/packages' = pkg_repl('sharutils','4.6.1-2',PKG_ARCH_DEFAULT);

#May fix some ui issue
#'/software/packages' = pkg_repl('ORBit','0.5.17-10.4','i386');
#'/software/packages' = pkg_repl('itcl','3.2-92.4','i386');
#'/software/packages' = pkg_repl('curl-compat-7.10.6-6','1.0.0-1','i386');
#'/software/packages' = pkg_repl('compat-libcom_err','1.0-5','i386');

# Site specific updates
# Always reinclude updates
include { 'config/os/updates' };





