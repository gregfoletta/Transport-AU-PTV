package Transport::AU::PTV::Error;

use strict;
use warnings;
use 5.010;

use constant {
    PACKAGE     => 0,
    FILENAME    => 1, 
    LINE       => 2, 
    SUB        => 3, 
    HASARGS    => 4, 
};

=encoding utf8

=head1 NAME

=head1 METHODS

=head2 new

=cut


# Autoload captures all non-defined subroutine calls.
# This allows for subroutine chaining to continue to work, finally returning
# the error.

sub AUTOLOAD { my $self = shift; return $self; };


=head2 message

    return Transport::AU::PTV::Error->message("Invalid response") if !$obj->some_sub;


Create the error object with an error message

=cut

sub message {
    my $self = shift;
    local $" = " - ";
    my $msg = "@_";
    return bless \$msg, $self;
}


=head2 error

Returns 1 if the object is a Transport::AU::PTV::Error object. Returns 0 if this has been inherited by any other object.

=cut

sub error {
    my $self = shift;

    return (ref $self eq __PACKAGE__) ? 1 : 0;
}

=head2 error_string

=cut

sub error_string {
    my $self = shift;
    return "${$self}";
}

=head2 die

=cut

sub die {
    my $self = shift;
    return unless ref $self eq __PACKAGE__;

    say STDERR "${$self}";
    exit(1);
}

1;
