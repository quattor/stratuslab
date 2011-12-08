# #
# Software subject to following license(s):
#   Apache 2 License (http://www.opensource.org/licenses/apache2.0)
#   Copyright (c) Centre National de la Recherche Scientifique
#

# #
# Current developer(s):
#   Charles LOOMIS <loomis@lal.in2p3.fr>
#

# 
# # 
# one_proxy, 1.10-SNAPSHOT, 20111202.1207.03
#

package NCM::Component::one_proxy;

use strict;
use warnings;

use base qw(NCM::Component);

use LC::Exception;
use LC::Find;
use LC::File qw(copy makedir);

use EDG::WP4::CCM::Element;
use EDG::WP4::CCM::Element qw(unescape);

use CAF::FileWriter;
use CAF::FileEditor;
use CAF::Process;
use File::Basename;
use File::Path;

use Readonly;

Readonly::Scalar my $PATH => '/software/components/one_proxy';

Readonly::Scalar my $PSWD_FILE => 'login-pswd.properties';
Readonly::Scalar my $CERT_FILE => 'login-cert.properties';
Readonly::Scalar my $JAAS_FILE => 'login.conf';

Readonly::Scalar my $RESTART => '/etc/init.d/one-proxy restart';

our $EC=LC::Exception::Context->new->will_store_all;

# Write the password configuration file.
sub format_pswd_file_contents {

    # Hash reference to user/pswd information. 
    my ($users) = @_;

    my $contents = '';
    
    foreach my $user (sort keys %$users) {

	my $entry = $users->{$user};
	my $pswd = $entry->{'password'};
	my $groups = $entry->{'groups'};
	my $groups_value = join(',', @$groups);

	$contents .= "$user=$pswd,$groups_value\n";
    }

    return $contents;
}

# Write the certificate configuration file.
sub format_cert_file_contents {

    # Hash reference to user information (by dn). 
    my ($users) = @_;

    my $contents = '';
    
    foreach my $user (sort keys %$users) {

	my $entry = $users->{$user};
	my $groups = $entry->{'groups'};
	my $groups_value = join(',', @$groups);

	$contents .= '"' . unescape($user) . '" ' . "$groups_value\n";
    }

    return $contents;
}

# Write one login module entry.
sub format_login_module_entry {

    # Hash reference to user information (by dn). 
    my ($login_module) = @_;

    my $contents = '';

    my $name = $login_module->{'name'};
    my $flag = $login_module->{'flag'};

    $contents .= "  $name $flag";

    my $options = $login_module->{'options'};
    
    foreach my $option (sort keys %$options) {
	my $value = $options->{$option};
	$contents .= "\n  $option=\"$value\"";
    }

    $contents .= ";\n";

    return $contents;
}

# Write the JAAS configuration file.
sub format_jaas_file_contents {

    # Hash reference JAAS entries. 
    my ($entries) = @_;

    my $contents = '';
    
    foreach my $entry (sort keys %$entries) {

	$contents .= "$entry {\n\n";

	my $login_modules = $entries->{$entry}->{'login_modules'};

	foreach my $login_module (@$login_modules) {
	    $contents .= format_login_module_entry($login_module);
	    $contents .= "\n";
	}

	$contents .= "};\n\n";
    }

    return $contents;
}

sub write_config_file {

    my ($fname, $contents) = @_;

    # Write out the contents of the configuration file.
    my $fh = CAF::FileWriter->open($fname);
    print $fh $contents;
    my $config_changed = $fh->close();
    
    return $config_changed;
}

# Restart the process.
sub restart_daemon {
    my ($self) = @_;
    CAF::Process->new([$RESTART], log => $self)->run();
    return;
}

sub Configure {

    my ($self, $config) = @_;

    # Get full tree of configuration information for component.
    my $t = $config->getElement($PATH)->getTree();
    my $params = $t->{'config'};
    my $config_dir = $t->{'dir'};

    # Create the password configuration file.
    my $contents = format_pswd_file_contents($params->{'users_by_pswd'});
    my $pswd_changed = write_config_file($config_dir."/".$PSWD_FILE, $contents);

    # Create the certificate authentication file.
    $contents = format_cert_file_contents($params->{'users_by_cert'});
    my $cert_changed = write_config_file($config_dir."/".$CERT_FILE, $contents);

    # Create the JAAS configuration file.
    $contents = format_jaas_file_contents($params->{'jaas'});
    my $jaas_changed = write_config_file($config_dir."/".$JAAS_FILE, $contents);

    # Restart the daemon if necessary.
    if ($pswd_changed || $cert_changed || $jaas_changed) {
	restart_daemon();
    }
}

1; # Required for perl module!
