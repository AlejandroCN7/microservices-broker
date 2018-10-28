#!/usr/bin/env perl6

use v6;

use Cro::HTTP::Server;
use Cro::HTTP::Router;

my %changes;
my $application = route {
    put -> $sha1, $file-name, $adds, $deletes {
        
        created $sha1, 'application/json', status => "OK";
    }
}

# Create the HTTP service object
my Cro::Service $service = Cro::HTTP::Server.new(
    :host('localhost'), :port(2314), :$application
);

# Run it
$service.start;

# Cleanly shut down on Ctrl-C
react whenever signal(SIGINT) {
    $service.stop;
    exit;
}