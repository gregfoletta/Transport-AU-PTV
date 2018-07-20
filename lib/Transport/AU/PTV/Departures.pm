package Transport::AU::PTV::Departures;


use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::Collection);
use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Departure;

=encoding utf8

=head1 NAME

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
