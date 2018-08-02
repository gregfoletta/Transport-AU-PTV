package Transport::AU::PTV::Routes;

# VERSION
# PODNAME
# ABSTRACT: a collection of routes on the Victorian Public Transport Network.

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
    my $train_routes = $

=head1 Description

This object is a collection of routes on the Victorian Public Transport network. It's a child object of L<Transport::AU::PTV::Collecton>, and inherits all of its methods.

=head1 Methods

=head2 new

    my $routes = Transport::AU::PTV::Routes->new( Transport::AU::PTV::APIRequest->new({...}), \%args );

Takes a L<Transport::AU::PTV::APIRequest> object and returns a list of routes available on the Melbourne PTV network. C<%args> can be:

=over 4

=item *

() - the entire list of routes is retrieved. 

=item * 
C<( name =E<gt> 'partial name' )> - filter on a partial match of the route name.

=back

=cut

sub new {
    my ($self, $api, $args_r) = @_;
    my %routes;

    $routes{api} = $api;
    my $api_response = $api->request('/v3/routes');

    return $api_response if $api_response->error;

    foreach (@{$api_response->content()->{routes}}) {
        push @{$routes{collection}}, Transport::AU::PTV::Route->raw($api, $_);
    }

    return bless \%routes, $self;
}



1;
