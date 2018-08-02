# NAME

Transport::AU::PTV - access Melbourne Public Transport data.

# VERSION

version 0.02

# Synopsis

    # Create a new object with the developer ID and the API key.
    # If the credentials are not specified it will attempt to use
    # the PERL_PTV_DEV_ID and PERL_PTV_API_KEY environment variables.
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
    $ptv->routes->find(id => 15)->stops->stop(id => 2)->departures();

# Description

This module provides access to version 3 of [Public Transport Victoria's](https://www.ptv.vic.gov.au/) API. This is best described by PTV itself:

> The API has been created to provide public transport timetable data to the public in the most dynamic and efficient way. By providing an API, PTV hopes to maximise both the opportunities for re-use of public transport data and the potential for innovation.

The hierarachy of objects is as such:

- The [Transport::AU::PTV](https://metacpan.org/pod/Transport::AU::PTV) network has train, tram, bus and VLine [Transport::AU::PTV::Routes](https://metacpan.org/pod/Transport::AU::PTV::Routes).
- Each [Transport::AU::PTV::Route](https://metacpan.org/pod/Transport::AU::PTV::Route) has [Transport::AU::PTV::Stops](https://metacpan.org/pod/Transport::AU::PTV::Stops) where the mode of transport picks up/drops off travellers.
- Each [Transport::AU::PTV::Stop](https://metacpan.org/pod/Transport::AU::PTV::Stop) has scheduled [Transport::AU::PTV::Departures](https://metacpan.org/pod/Transport::AU::PTV::Departures).
- Each [Transport::AU::PTV::Departure](https://metacpan.org/pod/Transport::AU::PTV::Departure) has real time data on the estimated departure time and whether the transport is at the platform.

# Errors

On an error the object returns an [Transport::AU::PTV::Error](https://metacpan.org/pod/Transport::AU::PTV::Error) object. 

# Methods

## new

    # Call the constructor with explicit arguments
    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        api_key => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });

    # If the environment variables 'PERL_PTV_DEV_ID' and 'PERL_PTV_API_KEY' are defined
    # then the constructor will use those:
    # bash# export PTV_DEV_ID=1234 PTV_API_KEY=a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa
    my $ptv = Transport::AU::PTV->new();

Creates a new Transport::AU::PTV object. Takes a developer ID and API key.

## routes

    my $routes = $ptv->routes();
    my $filtered_routes = $ptv->routes({ name => 'Upf' });

Returns a [Transport::AU::PTV::Routes](https://metacpan.org/pod/Transport::AU::PTV::Routes) object containing all routes of all types on the Melbourne PTV network. With no arguments it returns all of the routes on the network - train, tram, bus, etc. The `name` argument can be used to filter based on the name of the route. This filter supports a partial match of the name.

## route

    my $route = $ptv->route({ route_id => 15 });

Retrieve the route with a specific route ID.

# AUTHOR

Greg Foletta <greg@foletta.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Greg Foletta.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
