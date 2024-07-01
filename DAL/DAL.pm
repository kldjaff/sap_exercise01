use strict;
use warnings;
use JSON;
use DBI;

package DAL;

sub new {
    my ($class, $args) = @_; # since the values will be  
                             # passed dynamically 
    my $self = {
        # Database connection details
        db_name   => $args->{db_name} || 'exercise',
        db_user   => $args->{db_user} || 'C5383753',
        db_password => $args->{db_password} || '',
        db_host   => $args->{db_host} || 'localhost',  # Adjust if using a different host
        db_port   => $args->{db_port} || 5432  # Adjust if using a different port (default for Postgres)
    };

    # Connect to the database
    $self->{dbh} = DBI->connect(
        "dbi:Pg:dbname=$self->{db_name};host=$self->{db_host};port=$self->{db_port}",
        $self->{db_user},
        $self->{db_password},
    ) or die "Could not connect to database: $DBI::errstr";

    return bless $self, $class;
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

    # Fetch all rows and store them in an array
    my @rows;
    while (my $row = $sth->fetchrow_hashref) {
        push @rows, $row;
    }

    my $json = JSON->new->pretty->encode(\@rows);

    # Close the statement
    $sth->finish();

    return $json;
}

sub close_connection {
    my ($self) = @_;

    # Close database connection
    $self->{dbh}->disconnect() if $self->{dbh};
}

1;  # Make the package available2