package Transport::AU::PTV::Routes;

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::Collection);
use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Route;

=encoding utf8

=head1 NAME 

Transport::AU::PTV::Routes - a collection of Melbourne public transport routes (train, tram, bus, etc).

=head1 Synopsis

    my $routes = Transport::AU::PTV->new({ ...})->routes;


=head1 Description

=head1 Methods

=head2 new

    my $routes = Transport::AU::PTV::Routes->new( Transport::AU::PTV::APIRequest->new({...}) );

Takes a L<Transport::AU::PTV::APIRequest> object and returns a list of routes available on the Melbourne PTV network.

=cut

sub new {
    my ($self, $api) = @_;
    my @routes;
    my %routes;

    $routes{api} = $api;
    my $api_response = $api->request('/v3/routes');

    return $api_response if $api_response->error;

    foreach (@{$api_response->content()->{routes}}) {
        push @{$routes{collection}}, Transport::AU::PTV::Route->new($api, $_);
    }

    return bless \%routes, $self;
}


=head2 route 
    
    my $upfield_route = $routes->route({name => 'Upfield'});

Returns a single L<Transport::AU::PTV::Route> object based on filter criteria.
The routes can be filtered by either C<id> or C<name>. 

=cut

sub route {
    my $self = shift;
    my ($args) = @_;

    for my $route (@{$self->{collection}}) {
        return $route if ($args->{id} and $args->{id} == $route->id());
        return $route if ($args->{name} and $args->{name} eq $route->name());
    }

    return;
}





1;
