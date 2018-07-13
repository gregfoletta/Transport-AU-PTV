package Transport::AU::PTV::Stops;

use strict;
use warnings;
use 5.010;

use Transport::AU::PTV::Error;

sub new {
    my ($class, $api, $args_r) = @_;
    my %stops;

    $stops{api} = $api;
    my $api_response = $api->api_request("/v3/stops/route/$args_r->{route_id}/route_type/$args_r->{route_type}");

    $stops{stops} = $api_response->{stops};

    return bless \%stops, $class;
}


sub table {
    my $self = shift;
    my @headings = qw(route_type stop_id stop_latitude stop_latitude stop_name stop_sequence stop_suburb);

    local $" = "\t";
    say "@headings";
    foreach (@{$self->{stops}}) {
        say "@{$_}{@headings}";
    }
}



1;
