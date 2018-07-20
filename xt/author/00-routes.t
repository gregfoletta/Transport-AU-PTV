#!perl -T
use 5.010;
use strict;
use warnings;
use Test::More;

my %api_access;
@api_access{qw(dev_id api_key)} = @ENV{qw(PTV_DEV_ID PTV_API_KEY)};

BAIL_OUT('DevID or API key environment variables not set') unless (grep { defined $_ } values %api_access) == 2; 
 

use_ok( 'Transport::AU::PTV' ); 
my @methods = qw(routes);

my $ptv = Transport::AU::PTV->new(\%api_access);
isa_ok( $ptv, 'Transport::AU::PTV' );
ok( !$ptv->error, "Object creation - no error" ) or BAIL_OUT('Transport::AU::PTV creation error');

can_ok( $ptv, @methods );

my $routes = $ptv->routes();
ok( !$routes->error, "Routes creation - no error" ) or BAIL_OUT('Transport::AU::PTV::Routes creation error: '.$routes->error_string);
isa_ok( $routes, 'Transport::AU::PTV::Routes' );
isa_ok( $routes, 'Transport::AU::PTV::Collection' );

my @routes_methods = qw(
    route
);

my @collection_methods = qw(
    map
    grep
    count
    as_array
);

ok( $routes->count, "Routes > 0" );

can_ok( $routes, @routes_methods );
can_ok( $routes, @collection_methods );

# Go through each route and check to see if all of the routes have defined values for all of their attributes
foreach ($routes->as_array) {
    isa_ok( $_, 'Transport::AU::PTV::Route' );
    ok( defined $_->name, "Route Name: ". $_->name);
    ok( defined $_->id, "Route ID: ". $_->name. " - ". $_->id);
    ok( defined $_->type, "Route Type: ". $_->name. " - ". $_->type);
    ok( defined $_->number, "Route Number: ". $_->name. " - ". $_->number);
}


done_testing();

