package Board::Controller;
use strict;
use warnings;
use utf8;
use FindBin::libs;
use base qw( Board::Base Class::Accessor::Fast );

__PACKAGE__->mk_accessors( qw/tmt param/ );

sub dispatch_index {
    my ( $self, $param ) = @_;
    return ( '200', $self->tmt->render_file( 'index.html' )->as_string );
}

sub dispatch_error {
    my ( $self, $param ) = @_;
        $self->error eq 
    return ( '200', $self->tmt->render_file( 'index.html' )->as_string );
}

1;
