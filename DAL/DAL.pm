use strict;
use warnings;

use DBI;

package DAL;

sub new {
    my $class = shift;
    my $self = {};

    # Database connection details
    $self->{db_name}   = 'exerise';
    $self->{db_user}   = 'C5383753';
    $self->{db_password} = '';
    $self->{db_host}   = 'localhost';  # Adjust if using a different host
    $self->{db_port}   = 5432;  # Adjust if using a different port (default for Postgres)

    # Connect to the database
    $self->{dbh} = DBI->connect(
        "dbi:Pg:dbname=$self->{db_name};host=$self->{db_host};port=$self->{db_port}",
        $self->{db_user},
        $self->{db_password},
    ) or die "Could not connect to database: $DBI::errstr";

    bless $self, $class;
}

sub execute_query {
    my ($self, $query, @params) = @_;

    # Prepare the statement
    my $sth = $self->{dbh}->prepare($query) or die "Could not prepare statement: $DBI::errstr";

    # Bind parameters if provided
    if (@params) {
        $sth->bind_param(@params);
    }

    # Execute the query
    $sth->execute() or die "Could not execute query: $DBI::errstr";

    # Fetch results (adjust based on your needs)
    my @results = $sth->fetchall_arrayref({});

    # Close the statement
    $sth->finish();

    return @results;
}

sub close_connection {
    my ($self) = @_;

    # Close database connection
    $self->{dbh}->disconnect() if $self->{dbh};
}

1;  # Make the package available