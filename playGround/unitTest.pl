use strict;
use warnings;
use Test::More;
 
# Function to add two numbers
sub add_numbers {
    my ($num1, $num2) = @_;
    return $num1 + $num2;
}

# Test cases
plan tests => 2;  # Inform about 2 tests

is add_numbers(2, 3), 5, "Adding 2 and 3";
is add_numbers(-1, 4), 3, "Adding -1 and 4";

done_testing();  # Optional, indicates test completion