use strict;
use warnings;
use Test::More;
use lib '/Users/C5383753/github/github.tools.sap/exercise/DAL/';
use DAL;
use Mojo::Log;

my $log = Mojo::Log->new(level => 'debug');  # Adjust level as needed

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
my $query = "SELECT 1+1 AS result";

$log->info("Executing query: ", $query);  # Use placeholders for variables

subtest 'execute_query() test' => sub {
    my $json_data = $dal->execute_query($query);
    # Expected pretty-printed JSON
    my $expected_pretty = JSON->new->pretty->encode(decode_json('[{"result":2}]'));

    # Expected plain JSON
    my $expected_plain = '[{"result":2}]';

    $log->debug(
        "Expected JSON (pretty): ?",
        $expected_pretty
    );
    $log->debug(
        "Expected JSON (plain): ?",
        $expected_plain
    );

    # Test that the output matches either the pretty-printed or plain JSON

    is($json_data, $expected_pretty || $expected_plain, 'Correct JSON data returned');
};

subtest 'execute_non_query() for CREATE TABLE' => sub {
    my $create_table_query = <<'SQL';
CREATE TABLE IF NOT EXISTS public.tmp_users
(
    id integer NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    bio text COLLATE pg_catalog."default",
    CONSTRAINT tmp_users_pkey PRIMARY KEY (id)
)
SQL

    my $rows_affected = $dal->execute_non_query($create_table_query);

    $log->debug("Rows affected: ", $rows_affected);

    ok($rows_affected >= 0, 'Correct number of rows affected');
};


# Close the connection
$dal->close_connection();

done_testing();

$log->info("Tests are completed \n");