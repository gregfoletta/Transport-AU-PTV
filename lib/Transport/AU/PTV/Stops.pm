package Transport::AU::PTV::Stops;


use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::Collection);
use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Stop;

=encoding utf8

=head1 NAME

Transport::AU::PTV::Stops- a collection of Melbourne public transport stops (train, tram, bus, etc).

=head1 Synopsis

    # Access the stops directly
    my $direct_stops= Transport::AU::PTV::Stops->new( 
        Transport::AU::PTV::APIRequest->new({...}),
        { route_id => 4, route_type => 1 }
    );

    # Retrieve from a route
    $stops = Transport::AU::PTV->new({ ... })->routes->route(name => 'Upfield)->stops;


=head1 Description

=head1 Methods

=head2 new

=cut

sub new {
    my ($class, $api, $args_r) = @_;
    my %stops;

    $stops{api} = $api;
    my $api_response = $api->request("/v3/stops/route/$args_r->{route_id}/route_type/$args_r->{route_type}");
    return $api_response if $api_response->error;

    foreach (@{$api_response->content->{stops}}) {
        push @{$stops{collection}}, Transport::AU::PTV::Stop->new($api, $args_r->{route_id}, $_);
    }

    return bless \%stops, $class;
}


=head2 stop

=cut

sub stop {
    my $self = shift;
    my ($args_r) = @_;

    for my $stop ($self->as_array) {
        return $stop if ($args_r->{id} and $args_r->{id} == $stop->id());
        return $stop if ($args_r->{name} and $args_r->{name} eq $stop->name());
    }

    return;
}





1;
