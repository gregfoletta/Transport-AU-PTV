package Transport::AU::PTV::Collection;

# VERSION
# PODNAME
# ABSTRACT: collection parent class.

use strict;
use warnings;
use 5.010;

=encoding utf8

=head1 NAME

Transport::AU::PTV::Collecton - parent class for Transport::AU::PTV collection objects.

=head1 Synopsis

=head1 Description

=head1 Methods

=head2 new

=cut

sub new {
    my ($self, @objects, $constructor) = @_;
    my @collection;

    foreach (@objects) {
        push @collection, $constructor->($_);
    }

    return bless \@collection, $self;
}


=head2 map

    my @names = $collection->map(sub { $_->name });

Iterates over each object in the collection and runs subroutine. Each object is passed in to the sub as C<$_>.

Returns an array of the return value of each subroutine. The number of array elements will always equal the number of objects in the collection.

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

    my @matches = $collection->grep(sub { $_->name =~ s{A...b}xms };

Iterates over each of the objects and returns a L<Transport::AU::PTV::Collection> object of all the objects for which the subroutine passed to C<grep> returned 'true'.

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

=head2 first

    my $match = $collection->first(sub { $_->name eq 'A_Name' });

Like C<grep>, but returns the first object for which the subroutine returns true.

=cut

sub first {
    my $self = shift;
    my $f = shift;

    foreach ($self->as_array) {
        return $_ if $f->();
    }
}

=head2 find

    my $value = $collection->find({ name => 'value' });

Syntactic sugar for C<$collection->first(sub { $_->name eq 'value' });>. The key of the hashref is the method to run on the object. The value of the hashref is the expected return from that method. Equality is determined using 'eq', thus the return values are stringified before testing.

=cut

sub find {
    my $self = shift;
    my ($args_r) = @_;
    my @search  = %{$args_r};

    use constant {
        FUNCTION => 0,
        TERM => 1,
    };

    foreach ($self->as_array) {
        my $method = $_->can("$search[FUNCTION]");
        return Transport::AU::PTV::Error->message("find(): object does not have method '$search[FUNCTION]'") unless $method;

        my $ret = $method->($_);
        return $_ if $ret eq $search[TERM];
    }

    return Transport::AU::PTV::Error->message("find(): could not find '$search[TERM]'");
}


=head2 count

Returns the number of objects in the collection.

=cut

sub count {
    my $self = shift;
    return scalar @{$self->{collection}};
}

=head2 as_array 

    for my $object ($collection->as_array) { ... }

Returns the collection as an array of objects. No copying occurs, so the objects are references to the same objects within the collection.

=cut

sub as_array {
    my $self = shift;
    return @{$self->{collection}};
}


1;
