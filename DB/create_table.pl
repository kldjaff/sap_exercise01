use strict;
use warnings;

use lib '/Users/C5383753/github/github.tools.sap/exercise/DAL/';
use DAL;

my $args = {
    db_name   => 'exercise',
    db_user   => 'C5383753',
    db_password => '',
    db_host   => 'localhost', # Adjust if using a different host
    db_port   => 5432 # Adjust if using a different port (default for Postgres)
};

my $dal = DAL->new($args);

# Read the SQL script from the file
my $sql_script;
{
    local $/;
    open my $fh, "<", "/Users/C5383753/github/github.tools.sap/exercise/DB/create_tables.sql" or die "Could not open file: $!";
    $sql_script = <$fh>;
    close $fh;
}

# Execute the SQL script
eval {
    $dal->execute_non_query($sql_script);
};
if ($@) {
    warn "Error executing SQL script: $@";
}

$dal->close_connection();