package Transport::AU::PTV::Departure;

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;

=encoding utf8

=head1 NAME

=head1 METHODS

=head2 new

=cut

sub new {
    my $class = shift;
    my ($api, $departure) = @_;

    return bless { api => $api, departure => $departure }, $class;
}



=head2 scheduled_departure

=cut 

sub scheduled_departure { return $_[0]->{departure}{scheduled_departure_utc} // "<undef>" }

=head2 estimated_departure 

=cut 

sub estimated_departure { return $_[0]->{departure}{estimated_departure_utc} // "<undef>" }

=head2 at_platform

=cut

sub at_platform { return $_[0]->{departure}{at_platform}; }

=head2 platform_number

=cut

sub platform_number { return $_[0]->{departure}{platform_number}; }


1;
