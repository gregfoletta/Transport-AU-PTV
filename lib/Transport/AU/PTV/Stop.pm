package Transport::AU::PTV::Stop;

# VERSION
# PODNAME
# ABSTRACT: a stop on the Victorian Public Transport Network.

use strict;
use warnings;
use 5.010;

use parent qw(Transport::AU::PTV::NoError);

use Transport::AU::PTV::Error;
use Transport::AU::PTV::Departures;

=head1 NAME

Transport::AU::PTV::Stop - a stop on the Victorian Public Transport Network.

=head1 METHODS

=head2 new

    # The 'stop' key in the constructor is the object returned by the API call.
    my $stop = Transport::AU::PTV::Stop->new( Transport::AU::PTV::APIRequest->new({...}), { route_id => 15, stop => { } );

=cut

sub new {
    my $class = shift;
    my ($api, $args_r) = @_;

    return bless { api => $api, %{ $args_r } }, $class;
}

=head2 name

    my $stop_name = $stop->name;

Returns the name of the stop.

=cut

sub name { return $_[0]->{stop}{stop_name} };

=head2 type

    my $stop_type= $stop->type;

Returns the type of stop.

=cut

sub type { return $_[0]->{stop}{route_type} };

=head2 id

    my $stop_id = $stop->id;

Returns the stop ID.

=cut

sub id { return $_[0]->{stop}{stop_id} };

=head2 route_id

    my $route_id = $stop->route_id;

Returns the route ID for the stop.

=cut

sub route_id { return $_[0]->{route_id} };

=head2 departures

    my $following_departures = $route->departures;
    my $next_departure = $route->departures({ max_results => 1 });

Returns a L<Transport::AU::PTV::Departures> object representing the departures for the stop.

If no arguments are provided, returns all of the departures from the time of the request until the end of the day. B<Note:> the API will not return the estimated departure time unless the C<max_results> argument is provided.

=over 4

=item * 

C<max_results> - Limits the number of results returned. 

=back

=cut

sub departures {
    my $self = shift;
    my ($args_r) = @_;
    $args_r //= {};

    return Transport::AU::PTV::Departures->new( $self->{api}, { %{$args_r}, route_id => $self->route_id, route_type => $self->type, stop_id => $self->id } );

}






1;
