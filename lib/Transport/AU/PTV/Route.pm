package Transport::AU::PTV::Route;

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::APIRequest);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Stops;

sub new {
    my $class = shift;
    my ($api, $route) = @_;

    return bless { api => $api, route => $route }, $class;
}

sub id { return $_[0]->{route}{route_id}; }
sub gtfs_id { return $_[0]->{route}{route_gtfs_id}; }
sub number { return $_[0]->{route}{route_number}; }
sub name { return $_[0]->{route}{route_name}; }
sub type { return $_[0]->{route}{route_type}; }

sub stops {
    my $self = shift;

    return Transport::AU::PTV::Stops->new( $self->{api}, { route_id => $self->{route}{route_id}, route_type => $self->{route}{route_type} } );

}







1;
