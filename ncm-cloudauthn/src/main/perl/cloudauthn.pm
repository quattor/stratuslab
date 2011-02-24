# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

package NCM::Component::cloudauthn;

use strict;
use warnings;

use base qw(NCM::Component);

use LC::Exception;
use LC::Find;
use LC::File qw(copy makedir);

use EDG::WP4::CCM::Element;
use CAF::FileWriter;
use CAF::FileEditor;
use CAF::Process;
use File::Basename;
use File::Path;

use Readonly;
Readonly::Scalar my $PATH => '/software/components/cloudauthn';

our $EC=LC::Exception::Context->new->will_store_all;

# Write the password configuration file.
sub writePasswordFile {
}

# Write the certificate configuration file.
sub writeCertificateFile {
}

# Write the JAAS configuration file.
sub writeJAASFile {
}


# Restart the process.
sub restartDaemon {
    my ($self) = @_;
    CAF::Process->new([qw(/etc/init.d/jetty restart)], log => $self)->run();
    return;
}

sub Configure {
    my ($self, $config) = @_;

    # Get full tree of configuration information for component.
    my $t = $config->getElement($PATH)->getTree();

    # Create the password configuration file.
    writePasswordFile($t->{'users_by_pswd'});

    # Create the certificate authentication file.
    writeCertificateFile($t->{'user_by_cert'});

    # Create the JAAS configuration file.
    writeJAASFile($t->{'jaas'});

    # Restart the daemon if necessary.
    restartDaemon();
}

1; # Required for perl module!
