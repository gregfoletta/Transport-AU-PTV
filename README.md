# NAME 

Transport::AU::PTV - access Melbourne public transport data.

# Synopsis

    # Create a new object with the developer ID and the API key,.
    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        aaa_aaa => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });

    # Get all of the routes on the network.
    my $routes = $ptv->routes();
    # Returns a Transport::AU::PTV::Error object on error. The object stringifys to the error string.
    croak "$routes" if $routes->error;

    # Plurals (Routes, Stops, Departures) are collections. A few things can be done with collections:
    # They can be treated as arrays - below each topic variable is a Transport::AU::PTV::Route object.
    foreach ($routes->as_array) { say $_->name }

    # You can grep through them, which returns a subset of the same collection:
    my $train_routes = $routes->grep(sub { $_->type == 0 });

    # You can map, which returns an array:
    my @name_and_type = $routes->map(sub { { name => $_->name, type => $_>type } });

    # Chain calls together.
    $ptv->routes->route(id => 20)->stops->stop(id => 2)->departures();

# Description

This module provides access to version 3 of [Public Transport Victria's](https://www.ptv.vic.gov.au/) API. This is bes described by PTV itself:

> The API has been created to provide public transport timetable data to the public in the most dynamic and efficient way. By providing an API, PTV hopes to maximise both the opportunities for re-use of public transport data and the potential for innovation.

# Errors

On an error the object returns an [Transport::AU::PTV::Error](https://metacpan.org/pod/Transport::AU::PTV::Error) object. 

# Methods

## new

    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        api_key => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });

Creates a new Transport::AU::PTV object. Takes a developer ID and API key.

## routes

    my $routes = $ptv->routes();
    my $filtered_routes = $ptv->routes({ name => 'Upf' });

Returns a [Transport::AU::PTV::Routes](https://metacpan.org/pod/Transport::AU::PTV::Routes) object containing all routes of all types on the Melbourne PTV network. With no arguments it returns all of the routes on the network - train, tram, bus, etc. The `name` argument can be used to filter based on the name of the route. This filter supports a partial match of the name.
