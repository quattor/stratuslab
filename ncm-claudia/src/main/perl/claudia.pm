# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

package NCM::Component::claudia;

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
Readonly::Scalar my $PATH => '/software/components/claudia';

Readonly::Scalar my $RESTART => '/etc/init.d/claudia restart';

our $EC=LC::Exception::Context->new->will_store_all;

my $header = '####
#
# This file was generated by ncm-claudia.
# Please, do not edit it yourself. All your change
# will be remove on next quattor update.
#
';


sub Configure {
    my ($self, $config) = @_;

    # Get full tree of configuration information for component.
    my $t = $config->getElement($PATH)->getTree();
    my $cfg_sm = $t->{'sm-config'};

    my $sm_config_file = $cfg_sm->{'config_file'};

    my $contents = '';

    $contents .= ConfigureSm($cfg_sm);

    # Create the configuration file.
    my $sm_config = LC::Check::file(
           $sm_config_file,
                contents => $header.$contents,
                mode => 0644
        );
        if ( $sm_config < 0 ) {
          $self->error("Error creating $sm_config_file");
        }
   

}

sub ConfigureSm {
	my ($sm_config) = @_;
	my $contents = '';

	$contents .= "\n# JND Connection Properties\n";
	while ((my $k,my $v) = each(%{$sm_config->{java}}) ) {
     		$contents .= $k." = ".$v."\n";
    	}

	$contents .= "\n# Events Monitorization Rest Bus connection parameters\n";
	while ((my $k, my $v) = each(%{$sm_config->{'rest'}})) {
		$contents .= $k." = ".$v."\n";
	}

	$contents .= "\n#SMI Rest Server connection parameters\n";
	while ((my $k,my $v) = each(%{$sm_config->{SMI}}) ) {
     		$contents .= $k." = ".$v."\n";
    	}

	$contents .= "\n# HTTP Server for disk images\n";
	while ((my $k, my $v) = each(%{$sm_config->{'ImageServer'}})) {
		$contents .= $k." = ".$v."\n";
	}
	
	$contents .= "\n# VEEM Address.\n";
	while ((my $k, my $v) = each(%{$sm_config->{'VEEM'}})) {
		if ( $k eq 'ExtendedOCCI') {
		  $contents .= $k." = ".bool_to_string($v)."\n";
		} else {
		  $contents .= $k." = ".$v."\n";
		}
	}

	$contents .= "\n#Undeploy on server stop\n";
	$contents .= "UndeployOnServerStop = ".bool_to_string($sm_config->{'UndeployOnServerStop'})."\n";

	$contents .= "\n#ACD related info\n";
	$contents .= "ActivateAcd = ".bool_to_string($sm_config->{'ActivateAcd'})."\n";

	$contents .= "\n#Multicast monitoring address\n";
	$contents .= "MonitoringAddress = ".$sm_config->{'MonitoringAddress'}."\n";

	$contents .= "\n# WASUP Address.\n";
	while ((my $k, my $v) = each(%{$sm_config->{'WASUP'}})) {
		$contents .= $k." = ".$v."\n";
	}

	$contents .= "\n#Site root (used as FQN prefix)\n";
	$contents .= "SiteRoot = ".$sm_config->{'SiteRoot'}."\n";

	$contents .= "\n# Network ranges available for Service Manager use\n";
	foreach my $i (@{$sm_config->{'NetworkRanges'}}) {
		$contents .= "NetworkRanges = [";
		while ((my $k, my $v) = each(%{$i})) {
			if ( $k eq 'Public' ) {
			 $contents.= $k." = ".bool_to_string($v)."; ";
			} else {
			 $contents.= $k." = ".$v."; ";
			}
		}
		$contents .= "],";
	}

	$contents .= "\n# Mac Address\n";
#	foreach ((my $k, my $v) = each(%{$sm_config->{'NetworkMac'}})) {
#		$contents .= $k." = ".$v."\n";
#	}
	$contents .= " MacEnabled = ".$sm_config->{'NetworkMac'}->{'MacEnabled'}."\n";
	$contents .= " NetworkMacList = ".$sm_config->{'NetworkMac'}->{'NetworkMacList'}."\n";

	$contents .= "\nDomainName = ".$sm_config->{'DomainName'}."\n";

	$contents .= "\n#Setting the following to false disable the generation of <Entity> in OVF\n#Environments, which *violated DMTF DSP0243*\n";
	$contents .= "OVFEnvEntityGen = ".bool_to_string($sm_config->{'OVFEnvEntityGen'})."\n";

	return $contents;
};

sub bool_to_string {
	my ($bool) = @_;

	if ($bool) {
		return "true";
	} else {
		return "false";
	}
};

1; # Required for perl module!
