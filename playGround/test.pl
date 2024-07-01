

use strict; 
use warnings; 
use feature qw/say/;
use lib '/Users/C5383753/github/github.tools.sap/exercise/playGround';
use test;
  
# pass length and width arguments  
# to the constructor 

my $db_name = 'exercise';
my $db_user = 'C5383753';
my $db_password = '';  # Replace with your actual password
my $db_host = 'localhost';
my $db_port = 5432;

my $area = Area->new( { 
    db_name => $db_name,
    db_user => $db_user,
    db_password => $db_password,
    db_host => $db_host,
    db_port => $db_port,
    });

 
  
