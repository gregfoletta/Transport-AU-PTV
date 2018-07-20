package Transport::AU::PTV::Run;

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



1;
