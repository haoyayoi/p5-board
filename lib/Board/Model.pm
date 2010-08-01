package Board::Model;
use strict;
use warnings;
use base qw( Board::Base Class::Accessor::Fast );
use DBI;

__PACKAGE__->mk_accessors( qw/dbi/ );

sub new {
    my ( $class, $args ) = @_;
    my $self = bless {
        dbi => DBI->connect(
            $args->{dsn},
            $args->{username},
            $args->{password},
            {
                RaiseError => 1,
                AutoCommit => 0,
            }
        ),
    }, $class;
    return $self;
}

1;
