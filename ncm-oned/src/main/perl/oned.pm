# ${license-info}
# ${developer-info}
# ${author-info}
# ${build-info}

package NCM::Component::oned;

use strict;
use warnings;
use NCM::Component;
use EDG::WP4::CCM::Property;
use NCM::Check;
use FileHandle;
use File::Basename;

use CAF::FileWriter;
use CAF::Process;
use LC::File qw (makedir);

our $VERSION = q{${project.version}};

use Readonly;
Readonly::Scalar our $EMPTY => q{};
Readonly::Scalar our $PATH => '/software/components/oned';
Readonly::Scalar our $COMPONENT_NAME => 'oned';
Readonly::Scalar our $RESTART => '/etc/init.d/oned restart';

use base qw (NCM::Component);

our $EC = LC::Exception::Context->new->will_store_all;

# If the value isn't a number, then quotes are added.
sub quoteValue {
    my ($v) = @_;
    return (($v =~ m{^\d*$}x) ? $v :  q{"} . $v . q{"});
}

# Write out hash as sequence of key/value pairs.
sub writeKeyValuePairs {
    my ($href) = @_;
 
    my %pairs = %{$href};

    my @entries;
    foreach my $k (sort keys %pairs) {
        my $v = quoteValue($pairs{$k});
        push @entries, "$k=$v";
    }

    return join("\n", @entries) . "\n";
}

# Write out the database parameters.
sub writeDatabaseParams {
    my ($href) = @_;

    my %pairs = %{$href};

    my @entries;
    foreach my $k (sort keys %pairs) {
        my $v = quoteValue($pairs{$k});
        push @entries, "$k=$v";
    }

    my $contents = 'DB=[ ';
    $contents .= join(",\n    ", @entries);
    $contents .= " ]\n";

    return $contents;
}

# Write a single MAD definition.  
sub writeMad {
    my ($href, $name) = @_;

    my %pairs = %{$href};

    my $label = $pairs{'manager'} . '_MAD';

    my @entries;
    push @entries, 'name="' . $name . q{"};
    foreach my $k (sort keys %pairs) {
        if ($k ne 'manager') {
            my $v = quoteValue($pairs{$k});
            push @entries, "$k=$v";
        }
    }

    my $contents = $label . '=[ ';
    $contents .= join(",\n    ", @entries);
    $contents .= " ]\n\n";

    return $contents;
}

# Process a hash of MAD definitions.
sub processMads {
    my ($href) = @_;

    my %pairs = %{$href};

    my $contents = $EMPTY;

    foreach my $k (sort keys %pairs) {
        my %hvalue = %{$pairs{$k}};
        $contents .= writeMad(\%hvalue, $k);
    }

    return $contents;
}

# Process a single hook definition.
sub writeHook {
    my ($href, $name) = @_;

    my %pairs = %{$href};

    my @entries;
    push @entries, 'name="' . $name . q{"};
    foreach my $k (sort keys %pairs) {
        my $v = quoteValue($pairs{$k});
        push @entries, "$k=$v";
    }

    my $contents = 'VM_HOOK=[ ';
    $contents .= join(",\n    ", @entries);
    $contents .= " ]\n\n";

    return $contents;
}

# Process a hash of hook definitions.
sub processHooks {
    my ($href) = @_;

    my %pairs = %{$href};

    my $contents = $EMPTY;

    foreach my $k (sort keys %pairs) {
        my %hvalue = %{$pairs{$k}};
        $contents .= writeHook(\%hvalue, $k);
    }

    return $contents;
}

# Extract VM IDs from onehost list command.
sub get_vm_ids {
    my ($self) = @_;

    my @vmids; 

#    my $proc = CAF::Process->new([qw(su - oneadmin)], log => $self, verbose => 1);
#    $proc->pushargs("--command");
#    $proc->pushargs("'/usr/bin/onehost list'");
#    $proc->execute();
#    my $output = $proc->output();

    my $output = `su - oneadmin --command "onehost list"`;

    my @lines = split("^", $output);
    foreach my $line (@lines) {
	my ($dummy, $id) = split("\\s+", $line);
	if ($id =~ "\\d+") {
	    push(@vmids, $id);
	}
    }

    return \@vmids;
}


# Extract VM info from onehost show command given an ID.
sub get_vm_info {
    my ($self, $id) = @_;

    my %info;

#    my $proc = CAF::Process->new([qw(su - oneadmin)], log => $self, verbose => 1);
#    $proc->pushargs("--command=\"onehost show $id\"");
#    my $output = $proc->output();

    my $output = `su - oneadmin --command "onehost show $id"`;

    my @lines = split("^", $output);
    foreach my $line (@lines) {
	chomp($line);
	if ($line =~ m/.*:.*/) {
	    my ($key, $value) = split("\\s*:\\s*", $line);
	    $info{$key} = $value;
	}
    }

    return \%info;
}

# Given list of VM IDs, generate a list of host names.
sub get_vm_hosts {
    my ($self, $vmids_ref) = @_;

    my %hosts;

    foreach my $id (@$vmids_ref) {	

	my $info = $self->get_vm_info($id);
	if ($info->{'NAME'}) {
	    my $hostname = $info->{'NAME'};
	    $hosts{$hostname} = $id;
	}	

    }

    return \%hosts;
}


# Create a new host.
sub create_host {

    my ($self, $hostname, $host_info) = @_;

    my $im_mad = $host_info->{'im_mad'};
    my $tm_mad = $host_info->{'tm_mad'};
    my $vm_mad = $host_info->{'vm_mad'};

    $self->info("creating new host: $hostname");
    my $cmd = "su - oneadmin --command 'onehost create $hostname $im_mad $vm_mad $tm_mad dummy'";
    my $output = `$cmd`;

    return;
}

sub create_group {
	my ($self) = @_;

	$self->info("creating group users");
	my $output = `su - oneadmin --command "onegroup create users"`;

	return;
}

# Extract the existing OpenNebula networks. 
sub get_existing_vnets {
    my ($self) = @_;

    my %info;

#    my $proc = CAF::Process->new([qw(su - oneadmin)], log => $self, verbose => 1);
#    $proc->pushargs("--command=\"onehost show $id\"");
#    my $output = $proc->output();

    my $output = `su - oneadmin --command "onevnet list"`;

    my @lines = split("^", $output);
    foreach my $line (@lines) {
	chomp($line);
	my ($d1, $d2, $d3, $d4, $vnet_name) = split("\\s+", $line);
	$info{$vnet_name} = 1;
    }

    return \%info;
}


# Create a new OpenNebula vnet.
sub create_vnet {
    my ($self, $name, $contents) = @_;

#    my $proc = CAF::Process->new([qw(su - oneadmin)], log => $self, verbose => 1);
#    $proc->pushargs("--command=\"onehost show $id\"");
#    my $output = $proc->output();

    my $fname = "/home/oneadmin/$name.net";
    my %info;

    # Write out the contents of the configuration file.
    my $fh = CAF::FileWriter->open($fname);
    print $fh $contents;
    $fh->close();

    my $output = `su - oneadmin --command "onevnet create $fname"`;
    print $output;
    my @id = split("\\s+",$output);
    $output = `su - oneadmin --command "onegroup list"`;
    my @lines = split("^",$output);
    foreach my $line (@lines) {
        chomp($line);
        my ($d1, $id,$group) = split("\\s+",$line);
        $info{$group}= $id;
    }
    my $gid = $info{'users'};
    $output = `su - oneadmin --command "onevnet chmod $id[1] 644"`;
    $output = `su - oneadmin --command "onevnet chgrp $id[1] $gid"`;

    return;
}


# Restart the process.
sub restartDaemon {
    my ($self) = @_;
    CAF::Process->new([$RESTART], log => $self)->run();
    return;
}

sub Configure {
    my ($self, $config) = @_;

    my $t = $config->getElement($PATH)->getTree;

    # First retrieve the configuration file location.
    my $oned_config = $t->{'oned_config'};
    my $config_dir = basename($oned_config);
    if (!makedir($config_dir, oct(755))) {
        $self->error("Failed to create configuration directory: $config_dir");
        return;
    }

    # Accumulate the configuration in a string.
    my $contents = 
        "#\n". 
        "# autogenerated by $COMPONENT_NAME configuration module\n" . 
        "#\n";

    $contents .= "\n# general parameters\n\n";
    my %pairs = %{$t->{'daemon'}};
    $contents .= writeKeyValuePairs(\%pairs);

    $contents .= "\n# database parameters\n\n";
    %pairs = %{$t->{'db'}};
    $contents .= writeDatabaseParams(\%pairs);

    $contents .= "\n# networking parameters\n\n";
    %pairs = %{$t->{'network'}};
    $contents .= writeKeyValuePairs(\%pairs);

    $contents .= "\n# image repository parameters\n\n";
    %pairs = %{$t->{'image_repos'}};
    $contents .= writeKeyValuePairs(\%pairs);

    $contents .= "\n# MAD definitions\n\n";
    %pairs = %{$t->{'mads'}};
    $contents .= processMads(\%pairs);

    $contents .= "\n# hook definitions\n\n";
    %pairs = %{$t->{'hooks'}};
    $contents .= processHooks(\%pairs);

    # Write out the contents of the configuration file.
    my $fh = CAF::FileWriter->open("$oned_config");
    print $fh $contents;
    my $config_changed = $fh->close();

    # If configuration has changed restart the service.
    if ($config_changed) {
	$self->restartDaemon();
    }

    # With the daemon restarted now look after the hosts.
    my $vmids_ref = $self->get_vm_ids();
    my $existing_hosts = $self->get_vm_hosts(\@$vmids_ref);

    # Get hosts that should exist from the configuration.
    my $desired_hosts = $t->{'hosts'};

    # Create the hosts which don't exist yet.  Don't touch 
    # ones that already exist. 
    foreach my $desired_host (keys %$desired_hosts) {
	if (!defined($existing_hosts->{$desired_host})) {
	    $self->create_host($desired_host, $desired_hosts->{$desired_host});
	}
    }


	# Create group users to be sure it exist before network creation
    $self->create_group();


    # Also configure the networks.
    my $desired_vnets = $t->{'vnets'};

    # Get the existing networks.
    my $existing_vnets = $self->get_existing_vnets();
    
    # Create the nvets which don't exist yet.  Don't touch 
    # ones that already exist. 
    foreach my $desired_vnet (keys %$desired_vnets) {
	if (!defined($existing_vnets->{$desired_vnet})) {
	    $self->create_vnet($desired_vnet, $desired_vnets->{$desired_vnet});
	}
    }

    return 1;
}

1;
