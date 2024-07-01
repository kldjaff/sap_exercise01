use strict;
use warnings;
use Test::More;
use lib '/Users/C5383753/github/github.tools.sap/exercise/DAL/';
use DAL;

# Test database credentials (replace with your actual values)
my $db_name = 'exercise';
my $db_user = 'C5383753';
my $db_password = '';  # Replace with your actual password
my $db_host = '127.0.0.1';
my $db_port = 5432;

my $dal = DAL->new({
    db_name => $db_name,
    db_user => $db_user,
    db_password => $db_password,
    db_host => $db_host,
    db_port => $db_port
});

# Simple test query (replace with your own query for testing)
my $query = "SELECT 'AAA'AS result";

my @results = $dal->execute_query($query);

print $results[0];

$dal->close_connection();