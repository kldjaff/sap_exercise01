use strict;
use warnings;

use Test::More;
use FindBin qw($RealBin);  # For locating test data

# Mock object for database interaction (replace with actual connection for some tests)
use Test::Mock;

my $mock_db = Test::Mock->new();

package DBAccessLayer;

# Override connect method to use mock object
sub new {
    my $class = shift;
    my $self = {};
    $self->{connection} = $mock_db;  # Use mock for connection
    return bless $self, $class;
}

1;  # Make the package available (already defined)

# Restore original connect method (optional, for some tests)
my $orig_connect = sub { shift->SUPER::new(@_) };

plan tests => 10;  # Inform about 10 tests

# Test successful connection (using mock)
$mock_db->can('connect');
$mock_db->expect_last_call('connect');
my $db_access = DBAccessLayer->new("dummy_db", "dummy_user", "dummy_password");
is(defined($db_access), 1, "Successful object creation (mock connection)");

# Test failed connection (using mock)
$mock_db->can('connect');
$mock_db->expect_last_call('connect')->will_throw(qw(Connection failed));
$db_access = DBAccessLayer->new("dummy_db", "dummy_user", "dummy_password");
is(defined($db_access), 0, "Failed object creation (mock connection)");

# Test successful query execution (using mock)
$mock_db->can('prepare');
$mock_db->expect_last_call('prepare')->will_return("dummy_statement");
$mock_db->can('execute');
$mock_db->expect_last_call('execute');
$mock_db->can('fetchall_arrayref');
$mock_db->expect_last_call('fetchall_arrayref')->will_return([{"col1" => "value1"}]);
$db_access = DBAccessLayer->new();  # No actual connection needed for this test
$results = $db_access->execute_query("SELECT * FROM dummy_table;");
is(scalar(@results), 1, "Successful query execution (mock)");
is($results[0]{col1}, "value1", "Correct result retrieved (mock)");

# Test failed query execution (using mock)
$mock_db->can('prepare');
$mock_db->expect_last_call('prepare')->will_return("dummy_statement");
$mock_db->can('execute');
$mock_db->expect_last_call('execute')->will_throw(qw(Execution failed));
$db_access = DBAccessLayer->new();  # No actual connection needed for this test
$results = $db_access->execute_query("SELECT * FROM dummy_table;");
is(scalar(@results), 0, "Failed query execution (mock)");

# Test behavior with missing connection (using mock, uncomment restore)
# $orig_connect->();  # Uncomment to restore original connect method
# $db_access = DBAccessLayer->new("dummy_db", "dummy_user", "dummy_password");
# is(defined($db_access->execute_query("SELECT * FROM dummy_table;")), 0, "Empty results without connection");  # Adjust test as needed

# Additional tests (replace with actual database connection for these):
# - Test successful connection with real database credentials
# - Test failed connection with incorrect credentials
# - Test successful query execution with a real query against a populated table

done_testing();

# Cleanup mock object
$mock_db->reset();
