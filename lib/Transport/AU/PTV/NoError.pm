package Transport::AU::PTV::NoError;

# VERSION
# PODNAME
# ABSTRACT: parent class with C<error> method returning false.

use strict;
use warnings;
use 5.010;

=encoding utf8

=head1 NAME

=head1 METHODS

=head2 error 

=cut

sub error { return 0; }


1;
