use strict;
use warnings;
use Test::More;

use lib '/Users/C5383753/github/github.tools.sap/exercice/DAL/';
use DAL;

# Test database credentials (replace with your actual values)
my $db_name = 'exerise';
my $db_user = 'C5383753';
my $db_password = '';  # Replace with your actual password
my $db_host = '127.0.0.1';
my $db_port = 5423;

# Create a DAL object
my $dal = DAL->new(
    db_name => $db_name,
    db_user => $db_user,
    db_password => $db_password,
    db_host => $db_host,
    db_port => $db_port,
);

# Simple test query (replace with your own query for testing)
my $query = "SELECT 1 + 1 AS result";

# Execute the query and test the result
my @results = $dal->execute_query($query);
is(scalar @results, 1, "One row returned");
is($results[0]{result}, 2, "Query result is correct");

# Close the database connection
$dal->close_connection();

done_testing();
