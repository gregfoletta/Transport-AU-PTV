package Transport::AU::PTV::Runs;


use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::Collection);
use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Run;

=encoding utf8

=head1 NAME

Transport::AU::PTV::Runs- 

=head1 Synopsis

=head1 Description

=head1 Methods

=head2 new

=cut

sub new {
    my ($class, $api, $args_r) = @_;
    my %runs;

    $runs{api} = $api;
    my $api_response = $api->request("/v3/runs/route/$args_r->{route_id}/route_type/$args_r->{route_type}");
    return $api_response if $api_response->error;

    foreach (@{$api_response->content->{runs}}) {
        push @{$runs{collection}}, Transport::AU::PTV::Run->new($api, $_);
    }

    return bless \%runs, $class;
}




1;
