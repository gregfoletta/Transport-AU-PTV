package Transport::AU::PTV;

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;

use Transport::AU::PTV::APIRequest;
use Transport::AU::PTV::Routes;

=encoding utf8

=head1 NAME 

Transport::AU::PTV - access Melbourne public transport data.

=head1 Synopsis

    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        aaa_aaa => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });

    my $routes = $ptv->routes();
    foreach ($routes->as_array) {
        ...
    }

    # Chain calls together
    $ptv->routes->route(id => 20)->stops->stop(id => 2)->departures();

    # Collections ('Routes', 'Stops', 'Departures') have a map function
    my @stop_names = $ptv->routes->route(id => 20)->stops->map(sub { $_->nam() });


=head1 Description

=head1 Methods

=head2 new

    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        api_key => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });

Creates a new Transport::AU::PTV object. Takes a developer ID and API key.

=cut

sub new {
    my $class = shift;
    my ($credential_r) = @_;
    my %ret;

    $ret{api} = Transport::AU::PTV::APIRequest->new($credential_r);

    return bless \%ret, $class;
}

=head2 routes

Returns a L<Transport::AU::PTV::Routes> object containing all routes of all types on the Melbourne PTV network. 

    my $routes = $ptv->routes();

=cut

sub routes {
    my $self = shift;
    return Transport::AU::PTV::Routes->new( $self->{api} );
}

1;
