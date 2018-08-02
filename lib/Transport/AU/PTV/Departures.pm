package Transport::AU::PTV::Departures;

# VERSION
# PODNAME
# ABSTRACT: a collection of departures on the Victorian Public Transport Network.

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::Collection);
use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Departure;

=encoding utf8

=head1 NAME

Transport::AU::PTV::Departures - a collection of departures for a particular stop on the Victorian Public Transport network.

=head1 SYNOPSIS

   # Get the departures for a stop
    my $departures = Transport::AU::PTV->new
    ->routes->find({ name => 'Upfield' })
    ->stops->find({ name => "Coburg Station" })
    ->departures({ max_results => 1 });

=head1 METHODS

=head2 new

=cut

sub new {
    my ($class, $api, $args_r) = @_;
    my %departures;
    my ($stop_id, $route_id, $route_type) = delete @{$args_r}{qw(stop_id route_id route_type)};

    $departures{api} = $api;
    my $request_uri = "/v3/departures/route_type/$route_type/stop/$stop_id" . ($route_id ? "/route/$route_id" : "");
    my $api_response = $api->request($request_uri, $args_r);

    return $api_response if $api_response->error;


    foreach (@{$api_response->content->{departures}}) {
        push @{$departures{collection}}, Transport::AU::PTV::Departure->new($api, $_);
    }

    return bless \%departures, $class;
}


1;
