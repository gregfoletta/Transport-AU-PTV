package Transport::AU::PTV::Collection;

use strict;
use warnings;
use 5.010;

=encoding utf8

=head1 NAME

Transport::AU::PTV::Collecton - parent class for Transport::AU::PTV collection objects.

=head1 Synopsis

=head1 Description

=head1 Methods

=head2 map

=cut

sub map {
    my $self = shift;
    my $map_func = shift;
    my @ret;

    foreach ($self->as_array) {
        push @ret, $map_func->();
    }

    return @ret
}


=head2 grep

=cut

sub grep {
    my $self = shift;
    my $f = shift;
    my @ret;

    foreach ($self->as_array) {
        push @ret, $_ if $f->();
    }

    return bless { 
        api => $self->{api},
        collection => \@ret
    }, ref $self;
}

=head2 count

=cut

sub count {
    my $self = shift;
    return scalar @{$self->{collection}};
}

=head2 as_array 

=cut

sub as_array {
    my $self = shift;
    return @{$self->{collection}};
}


1;
