#!/usr/bin/perl

use strict;
use warnings;
use DBI;
use JSON;

# Database connection details
my $host = "localhost";
my $dbname = "exercise";
my $username = "C5383753";
my $password = "";
my $port = 5432;

# Connect to the PostgreSQL database
my $dsn = "DBI:Pg:dbname=$dbname;host=$host;port=$port";
my $dbh = DBI->connect($dsn, $username, $password, { RaiseError => 1, AutoCommit => 1 }) or die $DBI::errstr;

# Prepare and execute the SQL query
my $sql = 'SELECT * from users';
my $sth = $dbh->prepare($sql);
$sth->execute();

# Fetch and print the result
# Fetch all rows and store them in an array
my @rows;
while (my $row = $sth->fetchrow_hashref) {
    push @rows, $row;
}

print "All data are: @rows \n";

# Convert the array of rows to JSON
my $json = JSON->new->pretty->encode(\@rows);

# Print the JSON
print "$json\n";

my $perl_data = from_json($json);

# Access the Perl data structure
foreach my $user (@{$perl_data}) {
    foreach my $key (keys %{$user}) {
        print "$key: $user->{$key}\n";
    }
    print "\n";
}

# Convert Perl data structure back to JSON string
my $new_json_string = to_json($perl_data);
print "JSON string: $new_json_string\n";
# Clean up
$sth->finish();
$dbh->disconnect();