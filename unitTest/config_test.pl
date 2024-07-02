use strict;
use warnings;
use Test::More;

use lib '/Users/C5383753/github/github.tools.sap/exercise/configuration';
use MyConfig;
use JSON;

# Create a temporary config file for testing
my $test_config_file = 'unitTest/test_config.json';
my $test_config_data = {
    database => {
        host => 'localhost',
        port => 5432,
        user => 'myuser',
        password => 'mypassword'
    },
    email => {
        smtp_server => 'smtp.example.com',
        from => 'noreply@example.com'
    }
};
open my $fh, '>', $test_config_file or die "Could not open $test_config_file: $!";
print $fh to_json($test_config_data, { pretty => 1 });
close $fh;

# Test the Config module
subtest 'Load configuration' => sub {
    my $config = MyConfig->new({ config_path => $test_config_file });
    is_deeply($config->{config_data}, $test_config_data, 'Config data loaded correctly');
};

subtest 'Get configuration values' => sub {
    my $config = MyConfig->new({ config_path => $test_config_file });
    is($config->get_config_value('database.host'), 'localhost', 'Retrieve single-level key');
    is($config->get_config_value('email.smtp_server'), 'smtp.example.com', 'Retrieve nested key');
    is_deeply(
        JSON->new->decode($config->get_config_value('database')),
        $test_config_data->{database},
        'Retrieve hash as JSON'
    );
};

subtest 'Handle missing configuration keys' => sub {
    my $config = MyConfig->new({ config_path => $test_config_file });
    is($config->get_config_value('non_existent_key'), undef, 'Return undef for missing key');
};

# Clean up the temporary config file
unlink $test_config_file;

done_testing();