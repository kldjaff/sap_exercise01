use DBI;

package Area; 
  
sub new  
{ 
    my ($class, $args) = @_; # since the values will be  
                             # passed dynamically 
    my $self =  
    { 
        length => $args->{length} || 1, # by default the value is 1 (stored) 
        width  => $args->{width} || 1,  # by default the value is 1 (stored) 
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
  
# we have added the get_area function to 
# calculate the area as well 
sub get_area  
{ 
    my $self = shift; 
      
    # getting the area by multiplication 
    my $area = $self->{length} * $self->{width};  
    return $area; 
} 
1; 