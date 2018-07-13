package Transport::AU::PTV::Routes;

use strict;
use warnings;
use 5.010;

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Route;

sub new {
    my ($self, $api) = @_;
    my @routes;
    my %routes;

    $routes{api} = $api;
    my $api_response = $api->api_request('/v3/routes');

    foreach (@{$api_response->{routes}}) {
        push @{$routes{routes}}, Transport::AU::PTV::Route->new($api, $_);
    }

    return bless \%routes, $self;
}


sub route {
    my $self = shift;
    my ($args) = @_;

    for my $route (@{$self->{routes}}) {
        return $route if ($args->{id} and $args->{id} == $route->id());
    }
}

sub grep {
    my $self = shift;
    my $grep_sub = shift;
    my @matched_routes;

    foreach (@_) {
        push @matched_routes, $_ if $grep_sub->();
    }

    return bless { 
        root => $self->{root},
        routes => \@matched_routes
    }, __PACKAGE__;
}

sub count {
    my $self = shift;
    return scalar @{$self->{routes}};
}




1;
