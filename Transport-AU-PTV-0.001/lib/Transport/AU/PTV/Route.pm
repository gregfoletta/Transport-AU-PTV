package Transport::AU::PTV::Route;

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Stops;
use Transport::AU::PTV::Runs;

=encoding utf8

=head1 NAME

Transport::AU::PTV::Routes - a collection of Melbourne public transport routes (train, tram, bus, etc).

=head1 Synopsis

    # Get a single route from the list of all routes.
    my $route = Transport::AU::PTV->new({ ...})->routes->find({ id => 15 });
    my $route_name = $route->name;
    my $route_number = $route->number;

=head1 Description

This object represents a single route on the Public Transport Victoria network.

=head1 Methods

=head2 new

    my $route = Transport::AU::PTV::Route->( Transport::AU::PTV::APIRequest->new({ ... }, { route_id => 2 });

=cut

sub new {
    my $class = shift;
    my ($api, $args_ref) = @_;

    my $api_response = $api->request("/v3/routes/$args_ref->{route_id}");

    return $api_response if $api_response->error;
    
    return bless { api => $api, route => $api_response->content()->{route} }, $class;
}


=head2 raw 

The constructor for this object should not be called directly - instead the route should be accesses from the L<Transport::AU::PTV::Routes> object.

=cut

sub raw {
    my $class = shift;
    my ($api, $route) = @_;

    return bless { api => $api, route => $route }, $class;
}

=head2 id 

Returns the ID of the route.

=cut
sub id { return $_[0]->{route}{route_id}; }

=head2 gtfs_id 

    my $gtfs_id = $route->gtfs_id;

Returns the GTFS ID of the route.

=cut 

sub gtfs_id { return $_[0]->{route}{route_gtfs_id}; }

=head2 number

    my $number = $route->number

Returns the number of the route.

=cut

sub number { return $_[0]->{route}{route_number}; }

=head2 name

    my $name = $route->name;

Returns the name of the route

=cut

sub name { return $_[0]->{route}{route_name}; }

=head2 type

    my $type = $route->type;

Returns the type of route.

=cut

sub type { return $_[0]->{route}{route_type}; }


=head2 stops

    my $stops = $route->stops;

Returns a L<Transport::AU::PTV::Stops> collection object representing the stops on the route.

=cut

sub stops {
    my $self = shift;

    return Transport::AU::PTV::Stops->new( $self->{api}, { route_id => $self->{route}{route_id}, route_type => $self->{route}{route_type} } );
}

=head2 runs 

    my $runs = $route->runs;

Returns a L<Transport::AU::PTV::Runs> collection object representing the runs of the route.

=cut

sub runs {
    my $self = shift;

    return Transport::AU::PTV::Runs->new( $self->{api}, { route_id => $self->{route}{route_id}, route_type => $self->{route}{route_type} } );
}








1;
