# package Config;
# use strict;
# use warnings;
# use JSON;
# use File::Basename;
# use Cwd;
# use Mojo::Log;

# my $log = Mojo::Log->new(level => 'debug');  # Adjust level as needed
# my $current_file_path = __FILE__;
# my $current_dir_path = Cwd::abs_path(dirname($current_file_path));
# my $config_dir_path = "$current_dir_path/../configuration";
# $log->info("current_file_path: $current_file_path");
# $log->info("current_dir_path: $current_dir_path");
# $log->info("config_dir_path: $config_dir_path");

# # Load the config file
# sub new {
#     my ($class, $args) = @_; # since the values will be  
#                              # passed dynamically 
#     my $self = {
#         config_file   => $args->{config_path} || "$config_dir_path/config.json"
#     };

#     # Get config data
#     $log->info("$self->{config_file} \n"); 
#     $self->{config_data} = do {
#         open(my $json_fh, "<", $self->{config_file})
#             or die "Could not open '$self->{config_path}': $!";
#         local $/; decode_json(<$json_fh>);

#     };
#     return bless $self, $class;
# }

# # Get config data by key
# sub get_config_value {
#     my ($self, $key) = @_;
#     my @parts = split /\./, $key;
#     my $value = $self->{config_data};
#     foreach my $part (@parts) {
#         if (ref($value) eq 'HASH' && exists $value->{$part}) {
#             $value = $value->{$part};
#         } else {
#             $log->error("Config key '$key' not found");
#             return undef;
#         }
#     }
#     if (ref($value) eq 'HASH') {
#         return to_json($value, { pretty => 1 });
#     } else {
#         return $value;
#     }
# }
############################################

use lib '/Users/C5383753/github/github.tools.sap/exercise/configuration';
use MyConfig;

my $config = MyConfig->new();

my $db_host = $config->get_config_value('database');

print "db_host: $db_host\n";