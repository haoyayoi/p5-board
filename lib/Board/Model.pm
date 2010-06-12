package Board::Model;
use strict;
use warnings;
use DBIx::Skinny;

sub is_exsit_table {
    my ( $self, $arg ) = @_;
    $self->search('', { '' => $arg });
}

1;
