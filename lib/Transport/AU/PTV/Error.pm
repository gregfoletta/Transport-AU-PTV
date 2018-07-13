package Transport::AU::PTV::Error;

use strict;
use warnings;
use 5.010;

sub msg {
    my $self = shift;
    my ($msg) = @_;
    return bless \$msg, $self;
}


sub AUTOLOAD { my $self = shift; return $self; };


1;
