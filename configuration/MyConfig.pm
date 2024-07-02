package MyConfig;
use strict;
use warnings;
use JSON;
use File::Basename;
use Cwd;
use Mojo::Log;

my $log = Mojo::Log->new(level => 'debug');  # Adjust level as needed
my $current_file_path = __FILE__;
my $current_dir_path = Cwd::abs_path(dirname($current_file_path));
my $config_dir_path = "$current_dir_path/../configuration";
$log->info("current_file_path: $current_file_path");
$log->info("current_dir_path: $current_dir_path");
$log->info("config_dir_path: $config_dir_path");

# New function
sub new {
    my ($class, $args) = @_; # since the values will be  
                             # passed dynamically 
    my $self = {
        config_file   => $args->{config_path} || "$config_dir_path/config.json"
    };

    # Get config data
    $log->info("$self->{config_file} \n"); 
    $self->{config_data} = do {
        open(my $json_fh, "<", $self->{config_file})
            or die "Could not open '$self->{config_path}': $!";
        local $/; decode_json(<$json_fh>);

    };
    return bless $self, $class;
}

# Get config data by key
sub get_config_value {
    my ($self, $key) = @_;
    my @parts = split /\./, $key;
    my $value = $self->{config_data};
    foreach my $part (@parts) {
        if (ref($value) eq 'HASH' && exists $value->{$part}) {
            $value = $value->{$part};
        } else {
            $log->error("Config key '$key' not found");
            return undef;
        }
    }
    if (ref($value) eq 'HASH') {
        return to_json($value, { pretty => 1 });
    } else {
        return $value;
    }
}

1;