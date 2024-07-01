#!/usr/bin/perl

use Mojolicious::Lite;

# Define a route for the root URL
get '/' => sub {
    my $c = shift;
    $c->render(json => { message => 'Hello, World!' });
};

# Start the server
app->start;