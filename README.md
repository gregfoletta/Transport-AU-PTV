# NAME 

Transport::AU::PTV - access Melbourne public transport data.

# Synopsis

    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        aaa_aaa => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });

    my $routes = $ptv->routes();
    foreach ($routes->as_array) {
        ...
    }

    # Chain calls together
    $ptv->routes->route(id => 20)->stops->stop(id => 2)->departures();

    # Collections ('Routes', 'Stops', 'Departures') have a map function
    my @stop_names = $ptv->routes->route(id => 20)->stops->map(sub { $_->nam() });

# Description

# Methods

## new

    my $ptv = Transport::AU::PTV->new({
        dev_id  => '1234',
        api_key => 'a1aa1111-11aa-11aa-aaa1-1a1aaa11aaa1'
    });

Creates a new Transport::AU::PTV object. Takes a developer ID and API key.

## routes

Returns a [Transport::AU::PTV::Routes](https://metacpan.org/pod/Transport::AU::PTV::Routes) object containing all routes of all types on the Melbourne PTV network. 

    my $routes = $ptv->routes();
