package Transport::AU::PTV::Directions;


use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::Collection);
use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;

=encoding utf8

=head1 NAME

Transport::AU::PTV::Directions

=head1 Synopsis

=head1 Description

=head1 Methods

=head2 new

=cut

sub new {
    my ($class, $api, $args_r) = @_;
    my %directions;

    $directions{api} = $api;

    my $api_response = $api->request("/v3/directions/route/$args_r->{route_id}");
    return $api_response if $api_response->error;

    foreach (@{$api_response->content->{directions}}) {
    }

    return bless \%directions, $class;
}




1;
