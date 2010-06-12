#!/usr/local/bin/perl
package Board;
use strict;
use warnings;
use utf8;
use Config;
use FindBin::libs;
use base qw( Board::Base Class::Accessor::Fast );
use CGI;
use Text::MicroTemplate::File;
use Board::Model;
use Board::Controller;
use Config::INI;
use Carp qw/croak/;
use HTTP::Message;
use HTTP::Headers;

our $VERSION = '0.01';

my $CONTROLLER_CLASS  = "Board::Controller";

__PACKAGE__->mk_accessors(qw/path query dbi controller error/);

sub new {
    my ( $class, $path ) = @_;
    my $self = bless {
        path  => $path || '',
        query => CGI->new,
        dbi   => Board::Model->new(+{
            dsn      => 'dbi:mysql:database=test',
            username => 'root',
            password => '',
        }),
        controller => Board::Controller->new({
            tmt   => Text::MicroTemplate::File->new(
                include_path => $path . "/html",
            ),
        }),
    }, $class;
    $self->controller->tmt->{tag_start} = '<?tmt';
    return $self;
}

sub handle {
    my $self    = $_[0];
    my $command = $self->query->param('command') || 'index';
    
    if ( $command ne 'index' ) {
        $self->error( $self->invalied_check );
        $command = "error" if defined $self->error;
    }

    my $method = "dispatch_$command";
    my ( $code, $content ) = $self->controller->$method({
        error   => $self->error,
        param   => {
            boardid => $self->query->param('boardid'),
            parent  => $self->query->param('parent'),
        },
    });
    my $h = HTTP::Headers->new( Content_Type => 'text/html');
    my $r = HTTP::Message->new( $h, $content );
    print $r->as_string;
}

sub invalied_check {
    my $self = $_[0];
    
    my $boardid = $self->query->param('boardid');
    my $parent  = $self->query->param('parent');
    
    return $Board::Base::NOTHING_BOARD_ID
        unless $boardid;
    return $Board::Base::INVALIED_BOARD_ID
        unless $self->dbi->is_exsit_table( $boardid );
    return $Board::Base::INVALIED_PARENT
        unless $self->dbi->can_reply_to( $parent );
}

1;
