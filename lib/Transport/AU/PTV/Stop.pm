package Transport::AU::PTV::Stop;

use strict;
use warnings;
use 5.010;

use Transport::AU::PTV::Error;

use Transport::AU::PTV::Departures;

=head1 NAME

=head1 METHODS

=head2 new

=cut

sub new {
    my $class = shift;
    my ($api, $route_id, $stop) = @_;

    return bless { api => $api, stop => $stop, route_id => $route_id }, $class;
}

=head2 name

Returns the name of the stop.

=cut

sub name { return $_[0]->{stop}{stop_name} };

=head2 type

Returns the type of stop.

=cut

sub type { return $_[0]->{stop}{route_type} };

=head2 id

Returns the stop ID.

=cut

sub id { return $_[0]->{stop}{stop_id} };

=head2 route_id

Returns the route ID for the stop.

=cut

sub route_id { return $_[0]->{route_id} };

=head2 departures

    my $following_departures = $route->departures();
    my $next_departure = $route->departures({ max_results => 1 });

Returns a L<Transport::AU::PTV::Departures> object representing the departures for the stop.

If no arguments are provided, returns all of the departures from the time of the request until the end of the day.

B<Arguments>:

=over 4

=item * max_results

Limits the number of results returned.

=back





=cut

sub departures {
    my $self = shift;
    my ($args_r) = @_;

    return Transport::AU::PTV::Departures->new( $self->{api}, { %{$args_r}, route_id => $self->route_id, route_type => $self->type, stop_id => $self->id });

}






1;
