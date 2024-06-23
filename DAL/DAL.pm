use strict;
use warnings;

use DBIx::Class qw( fetchall );

package DBAccessLayer;

sub new {
    my $class = shift;
    my $self = {};
    $self->{connection} = undef;

    my ($db_name, $db_user, $db_password, $db_host, $db_port) = @_;

    eval {
        $self->{connection} = DBIx::Class->connect(
            driver   => 'Pg',
            db_name  => $db_name,
            user     => $db_user,
            password => $db_password,
            host     => $db_host,
            port     => $db_port,
        );
    };

    if (!$@) {
        return bless $self, $class;
    } else {
        warn "Error connecting to database: $@";
        return undef;
    }
}

sub execute_query {
    my ($self, $query) = @_;

    unless ($self->{connection}) {
        return [];
    }

    my $sth;
    my @results;

    eval {
        $sth = $self->{connection}->prepare($query);
        $sth->execute();
        @results = $sth->fetchall_arrayref({});
    };

    if (!$@) {
        return [@results];
    } else {
        warn "Error executing query: $@";
        return [];
    }
}

sub close_connection {
    my ($self) = @_;

    if ($self->{connection}) {
        $self->{connection}->disconnect();
    }
}

1;  # Make the package available