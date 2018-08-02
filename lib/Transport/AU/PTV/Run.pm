package Transport::AU::PTV::Run;

# VERSION
# PODNAME
# ABSTRACT: a run on the Victorian Public Transport Network.

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;

=head1 NAME

=head1 METHODS

=head2 new

=cut

sub new {
    my $class = shift;
    my ($api, $run) = @_;

    return bless { api => $api, run => $run }, $class;
}


=head2 run_id

    my $id = $run->run_id;

Returns the ID for the run

=cut

sub run_id { return $_[0]->{run}{run_id} }

=head2 status

Returns the status of the route. Can be 'scheduled', 'added' or 'cancelled'

=cut

sub status { return $_[0]->{run}{status} }

=head2 direction_id

The direction ID for the run.

=cut

sub direction_id { return $_[0]->{run}{direction_id} }

=head2 run_sequence 

The sequence of stops for the run

=cut

sub run_sequence { return $_[0]->{run}{run_sequence} }




1;
